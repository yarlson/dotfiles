-- Globals for Neovim Lua configuration
globals = {
    "vim",
    -- Additional Neovim-related globals
    "assert",
    "pcall",
    "xpcall",
    "select",
    "pairs",
    "ipairs",
    "type",
    "tonumber",
    "tostring",
    "error",
    "warn",
    -- Common modules/plugins often used in Neovim config
    "require",
    "packer",
    "use",
}

-- Standard globals to ignore
ignore = {
    "111", -- Setting non-standard global
    "212", -- Unused argument
    "213", -- Unused loop variable
    "542", -- Empty if branch
}

-- Files to exclude
exclude_files = {
    "lua/lazy-lock.json",
    "lazy-lock.json",
    ".luacheckrc",
    "*.json",
    "*.txt",
    "*.md"
}

-- Maximum line length
max_line_length = 160

-- Allow self to be defined as a parameter in class methods
self = false

-- Set max cyclomatic complexity (prevents deeply nested code)
max_cyclomatic_complexity = 15

-- Standard Lua stdlib
std = "lua54"  -- LuaJIT is closest to Lua 5.4 
