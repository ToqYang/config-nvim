" Allow mouse
set mouse=a
" Activate syntax in vim
"syntax enable
" Show shortcuts in the bottom CLI of vim
set showcmd
" Encoding 
set encoding=utf-8
" Close parentheses opened
set showmatch
" Relative number from current set position cursor
set relativenumber
" Syntax
" |syntax on
set completeopt=menu,menuone,noselect
" Current number column
set cursorline

set clipboard=unnamed


" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Nvim Tree and icons -> File explorer(https://github.com/kyazdani42/nvim-tree.lua)
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Search in the files https://github.com/junegunn/fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Theme of the nvim
" (https://github.com/EdenEast/nightfox.nvim) - nightfox
Plug 'EdenEast/nightfox.nvim'

" (https://github.com/nvim-lualine/lualine.nvim) - Theme of the Bottom bar
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these NVIM icons

" (https://github.com/windwp/nvim-autopairs) Close tags () - {} - etc
Plug 'windwp/nvim-autopairs'
" Close tags HTML

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" (https://github.com/mg979/vim-visual-multi) - Multiple cursors to edit variable
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" (https://github.com/easymotion/vim-easymotion) - Search word with focus
Plug 'easymotion/vim-easymotion'
" (https://github.com/airblade/vim-gitgutter) - Chnages of git -, +, ~
Plug 'airblade/vim-gitgutter' 
" (https://github.com/lukas-reineke/indent-blankline.nvim) - Line to specific separation levels
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP format, linter, etc
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

" (https://github.com/glepnir/lspsaga.nvim) Lsp with steroids
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }


" () Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For luasnip users is used to autocomplete too.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Tabnine
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" (https://github.com/nvim-treesitter/nvim-treesitter) - Colors in the code
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" (https://github.com/nvim-lua/plenary.nvim) - Async lua
Plug 'nvim-lua/plenary.nvim'
" (https://github.com/nvim-telescope/telescope.nvim) - Telescope like fzf
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" () - Sort of the fzf
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" (https://github.com/folke/trouble.nvim) - BarBottom with problems
Plug 'folke/trouble.nvim'

" (https://github.com/romgrk/barbar.nvim) - Top buffers, tabs
Plug 'romgrk/barbar.nvim'



" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme nordfox
set termguicolors

augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

lua <<EOF
require("init")
local async = require "plenary.async"

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
--Tabnine setup


  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }


local tabnine = require('cmp_tabnine.config')

tabnine.setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
	ignored_file_types = { 
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
	show_prediction_strength = false
})
EOF
