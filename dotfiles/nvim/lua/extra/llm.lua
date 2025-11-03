-- improve text selected with AI
function improve_selected_text()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get start and end positions of the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- Adjust for Lua 0-based indexing (rows and columns)
    local start_row = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_row = end_pos[2] - 1
    local end_col = end_pos[3]

    -- Get the last line of the selection
    local last_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, true)[1] or ""

    -- Ensure end_col does not exceed the length of the last line
    end_col = math.min(end_col, #last_line)

    -- Get the selected text
    local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

    -- Join selected lines into a single query string
    local query = table.concat(lines, "\n")

    -- Run the shell command with the query
    local handle = io.popen('llm -m gpt-4o-mini -t improve "' .. query:gsub('"', '\\"') .. '"')
    if not handle then
        vim.notify("Failed to run shell command", vim.log.levels.ERROR)
        return
    end

    local result = handle:read("*a")
    handle:close()

    -- Split the result into lines for insertion
    local result_lines = vim.split(result, "\n", { plain = true, trimempty = true })

    -- Replace the selected coordinates with the result
    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, result_lines)

    -- Format the replaced text
    vim.cmd("normal! gqap")
end

-- Map the function to a keybinding, mnemonics: ist = improve selected text
vim.api.nvim_set_keymap('v', '<leader>ist', [[:lua improve_selected_text()<CR>]], { noremap = true, silent = true })
-- end of AI improve text function
