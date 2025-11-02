local utils = {}

-- require all lua files in 'lua/' with 'directory'
utils.load_all = function (directory)
  local path = vim.fn.stdpath("config") .. "/lua/" .. directory
  local files = vim.fn.readdir(path, [[v:val =~ '\.lua$']])
  for _, file in ipairs(files) do
    -- file: config/setting.lua -> config.setting
    local config_file = directory .. "." .. file:gsub("%.lua$", "")
    -- if importing fail, notify and go to the next file
    if not pcall(require, config_file) then
      vim.notify_once("Error loading: " .. file, vim.log.levels.ERROR)
    end
  end
end

-- returns this table of functions
return utils
