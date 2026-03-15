-- Bootstrap vim-plug
local data_dir = vim.fn.stdpath('data') .. '/site'
local plug_path = data_dir .. '/autoload/plug.vim'

if vim.fn.empty(vim.fn.glob(plug_path)) == 1 then
  vim.fn.system({
    'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
end

vim.cmd([[
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif
]])

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- UI
Plug('nvim-lualine/lualine.nvim')
Plug('romgrk/barbar.nvim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('norcalli/nvim-colorizer.lua')
Plug('RRethy/vim-illuminate')
Plug('rcarriga/nvim-notify')
Plug('nvim-tree/nvim-web-devicons')

-- Theme
Plug('arcticicestudio/nord-vim')

-- Navigation
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug('nvim-lua/plenary.nvim')
Plug('ahmedkhalf/project.nvim')

-- Git
Plug('tpope/vim-fugitive')
Plug('airblade/vim-gitgutter')

-- Editing
Plug('tpope/vim-surround')
Plug('folke/which-key.nvim')
Plug('cappyzawa/trim.nvim')

-- LSP/Completion
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

-- Start screen
Plug('goolord/alpha-nvim')

-- Sudo
Plug('lambdalisue/suda.vim')

vim.call('plug#end')

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 10
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.backup = false
vim.opt.writebackup = false

-- Theme
vim.cmd('syntax enable')
vim.cmd('colorscheme nord')

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- coc-explorer
map('n', 'sf', ':CocCommand explorer<CR>', opts)

-- Buffer navigation (barbar)
map('n', ';j', '<Cmd>BufferPrevious<CR>', opts)
map('n', ';k', '<Cmd>BufferNext<CR>', opts)
map('n', ';x', '<Cmd>BufferClose<CR>', opts)
map('n', ';xx', '<Cmd>BufferRestore<CR>', opts)

-- Telescope
map('n', ';f', '<Cmd>Telescope find_files<CR>', opts)
map('n', ';r', '<Cmd>Telescope live_grep<CR>', opts)
map('n', ';;', '<Cmd>Telescope buffers<CR>', opts)

-- New lines without insert mode
map('n', '<CR>', 'o<Esc>', opts)
map('n', '<A-CR>', 'O<Esc>', opts)

-- Clipboard
map('v', '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+yg_', opts)
map('n', '<leader>y', '"+y', opts)
map('n', '<leader>yy', '"+yy', opts)
map('n', '<leader>p', '"+p', opts)
map('n', '<leader>P', '"+P', opts)
map('v', '<leader>p', '"+p', opts)
map('v', '<leader>P', '"+P', opts)

-- Disable arrow keys
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- Disable q/Q
map('n', 'q', '<Nop>', opts)
map('n', 'Q', '<Nop>', opts)

-- CoC keymaps
-- Use Tab for trigger completion
vim.cmd([[
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
]])

-- GoTo code navigation
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Show documentation
vim.cmd([[
  nnoremap <silent> K :call ShowDocumentation()<CR>
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])

-- Rename symbol
map('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

-- Format selected code
map('x', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })
map('n', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })

-- AutoCommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight trailing whitespace
augroup('TrailingWhitespace', { clear = true })
autocmd('InsertEnter', {
  group = 'TrailingWhitespace',
  pattern = '*',
  command = 'match Error /\\s\\+\\%#\\@<!$/'
})
autocmd('InsertLeave', {
  group = 'TrailingWhitespace',
  pattern = '*',
  command = 'match Error /\\s\\+$/'
})

-- Cursorline only in active window
augroup('CursorLineOnlyInActiveWindow', { clear = true })
autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = 'CursorLineOnlyInActiveWindow',
  pattern = '*',
  callback = function() vim.opt_local.cursorline = true end
})
autocmd('WinLeave', {
  group = 'CursorLineOnlyInActiveWindow',
  pattern = '*',
  callback = function() vim.opt_local.cursorline = false end
})

-- Terraform filetype
augroup('Terraform', { clear = true })
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'Terraform',
  pattern = { '*.tf', '*.tfvars' },
  callback = function() vim.bo.filetype = 'terraform' end
})

-- Highlight customization
vim.cmd([[
  augroup CustomHighlights
    autocmd!
    autocmd ColorScheme * highlight BufferCurrent guibg=#3b4252 guifg=#eceff4
    autocmd ColorScheme * highlight BufferCurrentMod guibg=#3b4252 guifg=#ebcb8b
    autocmd ColorScheme * highlight BufferInactive guibg=#2e3440 guifg=#4c566a
    autocmd ColorScheme * highlight MatchParen guibg=#4c566a guifg=#88c0d0 gui=bold
  augroup END
]])

-- Plugin configurations (safe require)
local function safe_require(module)
  local ok, m = pcall(require, module)
  if ok then return m end
  return nil
end

-- Lualine
local lualine = safe_require('lualine')
if lualine then
  lualine.setup({
    options = {
      theme = 'nord',
      section_separators = '',
      component_separators = '',
    },
  })
end

-- Indent-blankline
local ibl = safe_require('ibl')
if ibl then
  ibl.setup({
    indent = { char = '|' },
    scope = { enabled = false },
  })
end

-- Colorizer
local colorizer = safe_require('colorizer')
if colorizer then
  colorizer.setup()
end

-- Telescope
local telescope = safe_require('telescope')
if telescope then
  telescope.setup({
    defaults = {
      file_ignore_patterns = { 'node_modules', '.git/' },
    },
  })
end

-- Project.nvim
local project = safe_require('project_nvim')
if project then
  project.setup({
    detection_methods = { 'pattern' },
    patterns = { '.git', 'Makefile', 'package.json', 'flake.nix' },
  })
end

-- Which-key
local which_key = safe_require('which-key')
if which_key then
  which_key.setup({})
end

-- Trim
local trim = safe_require('trim')
if trim then
  trim.setup({
    ft_blocklist = { 'markdown' },
  })
end

-- Alpha (start screen)
local alpha = safe_require('alpha')
local dashboard = safe_require('alpha.themes.dashboard')
if alpha and dashboard then
  dashboard.section.header.val = {
    '                                   ',
    '   ████╗  ██╗██╗   ██╗██╗███╗   ███╗',
    '   ██╔██╗ ██║██║   ██║██║████╗ ████║',
    '   ██║╚██╗██║██║   ██║██║██╔████╔██║',
    '   ██║ ╚████║╚██╗ ██╔╝██║██║╚██╔╝██║',
    '   ██║  ╚███║ ╚████╔╝ ██║██║ ╚═╝ ██║',
    '   ╚═╝   ╚══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
    '                                   ',
  }
  dashboard.section.buttons.val = {
    dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
    dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
    dashboard.button('g', '  Find word', ':Telescope live_grep<CR>'),
    dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
    dashboard.button('q', '  Quit', ':qa<CR>'),
  }
  alpha.setup(dashboard.config)
end

-- Notify
local notify = safe_require('notify')
if notify then
  vim.notify = notify
end

-- nvim-web-devicons
local devicons = safe_require('nvim-web-devicons')
if devicons then
  devicons.setup({ default = true })
end
