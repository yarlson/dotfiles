const std = @import("std");

/// Determines the XDG data directory path following the XDG Base Directory
/// Specification.
fn getXdgDataHome(allocator: std.mem.Allocator) ![]u8 {
    return std.process.getEnvVarOwned(allocator, "XDG_DATA_HOME") catch |err| switch (err) {
        error.EnvironmentVariableNotFound => {
            const home_path = try std.process.getEnvVarOwned(allocator, "HOME");
            defer allocator.free(home_path);

            return std.fs.path.join(allocator, &.{
                home_path,
                ".local",
                "share",
            });
        },
        else => return err,
    };
}

/// Creates a directory if it doesn't exist
fn ensureDirectory(path: []const u8) !void {
    std.fs.makeDirAbsolute(path) catch |err| switch (err) {
        error.PathAlreadyExists => {},
        else => return err,
    };
}

/// Constructs the cache file path for weather data storage
fn getCachePath(allocator: std.mem.Allocator) ![]u8 {
    const data_home = try getXdgDataHome(allocator);
    defer allocator.free(data_home);

    const cache_dir = try std.fs.path.join(allocator, &.{ data_home, "sketchybar", "weather" });
    defer allocator.free(cache_dir);

    try std.fs.cwd().makePath(cache_dir);
    return std.fs.path.join(allocator, &.{ cache_dir, "cache.txt" });
}

/// Cache operations result type
const CacheResult = struct {
    data: []u8,
    allocator: std.mem.Allocator,

    pub fn deinit(self: CacheResult) void {
        self.allocator.free(self.data);
    }
};

/// Reads cached weather data from the specified path
fn readCache(allocator: std.mem.Allocator, cache_path: []const u8) !CacheResult {
    const file = try std.fs.openFileAbsolute(cache_path, .{ .mode = .read_only });
    defer file.close();

    const data = try file.readToEndAlloc(allocator, 1024);
    return CacheResult{ .data = data, .allocator = allocator };
}

/// Writes weather data to the cache file
fn writeCache(cache_path: []const u8, data: []const u8) !void {
    const file = try std.fs.createFileAbsolute(cache_path, .{});
    defer file.close();
    try file.writeAll(data);
}

/// Weather fetching errors
const WeatherError = error{
    FetchFailed,
    CacheReadFailed,
    InvalidResponse,
};

/// Fetches current weather data from wttr.in API
fn fetchWeather(allocator: std.mem.Allocator) ![]const u8 {
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();

    const url_format = "https://v2n.wttr.in/?format=%c%t";
    const uri = try std.Uri.parse(url_format);

    var headers_buffer: [1024]u8 = undefined;
    var req = try client.open(.GET, uri, .{
        .server_header_buffer = &headers_buffer,
    });
    defer req.deinit();

    try req.send();
    try req.wait();

    return if (req.response.status == .ok)
        req.reader().readAllAlloc(allocator, 1024 * 1024)
    else
        WeatherError.InvalidResponse;
}

/// Weather result type for explicit ownership
const WeatherResult = struct {
    data: []const u8,
    allocator: std.mem.Allocator,

    pub fn deinit(self: WeatherResult) void {
        self.allocator.free(self.data);
    }
};

/// Retrieves weather information with caching support
fn getWeather(allocator: std.mem.Allocator, cache_path: []const u8) !WeatherResult {
    const weather_data = fetchWeather(allocator) catch {
        if (readCache(allocator, cache_path)) |cache| {
            return WeatherResult{
                .data = cache.data,
                .allocator = allocator,
            };
        } else |_| {
            return WeatherError.CacheReadFailed;
        }
    };

    // Separate error handling for cache writing
    writeCache(cache_path, weather_data) catch {};

    return WeatherResult{
        .data = weather_data,
        .allocator = allocator,
    };
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const cache_path = try getCachePath(allocator);
    defer allocator.free(cache_path);

    var weather_result = try getWeather(allocator, cache_path);
    defer weather_result.deinit();

    const trimmed = std.mem.trimRight(u8, weather_result.data, &.{ ' ', '\n', '\r' });
    try std.io.getStdOut().writer().print("{s}", .{trimmed});
}
