-- Compatibility shims for pinned plugins that lag current Neovim APIs.
if type(vim.lsp.get_clients) == 'function' and (vim.fn.has 'nvim-0.12' == 1 or vim.lsp.buf_get_clients == nil) then
  vim.lsp.buf_get_clients = function(bufnr)
    local clients = {}

    for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr or 0 }) do
      clients[client.id] = client
    end

    return clients
  end
end
