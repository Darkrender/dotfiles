vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })

-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
vim.keymap.set('t', '<c-space>', '<c-\\><c-n> :q<CR>', { desc = 'exit terminal mode' })

-- tip: disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "use j to move!!"<cr>')

-- keybinds to make split navigation easier.
--  use ctrl+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })

-- keybinds for yanking the entire file and for easily moving selected lines around
vim.keymap.set('n', '<leader>y', 'gg"+yg', { desc = 'yank entire file and share it with system clipboard', noremap = true })

vim.keymap.set('v', '<c-j>', ":m '>+1<cr>gv=gv", { desc = 'move selection line down one line', noremap = true })
vim.keymap.set('v', '<c-k>', ":m '<-2<cr>gv=gv", { desc = 'move selection line up one line', noremap = true })

-- fixes issue where ctrl+c causes lsp diagnostics not to show when exiting insert mode
vim.keymap.set('i', '<c-c>', '<esc>', { desc = 'rebinding ctrl+c to escape' })

vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Calls git status and opens fugitive git window' })

-- open terminal at bottom
vim.keymap.set('n', '<c-space>', ':15split | term<CR> i', { desc = 'Opens a new terminal at bottom' })
