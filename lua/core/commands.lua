
vim.api.nvim_create_user_command('EpochConv', function()
  local line_start, line_end = vim.fn.line("'["), vim.fn.line("']")
  for i = line_start, line_end do
    local line = vim.fn.getline(i)
    local new_line = line:gsub("(%d%d%d%d%d%d%d%d%d%d)", function(epoch)
      return os.date("!(%j) %Y-%m-%d %H:%M:%S UTC", tonumber(epoch))
    end)
    vim.fn.setline(i, new_line)
  end
end, { range = true })

-- local function Tata()
--  print("HUEHUE")
-- end
--
-- vim.api.nvim_create_user_command("Greet", function(opts)
--   Tata()
-- end, { nargs = "?" })
local function vmap(keys, fn, desc) 
         vim.keymap.set('v', keys, fn, { desc = desc, noremap = true }) 
 end 

vmap('<LeftRelease>', '"*ygv', 'yank on mouse selection')
