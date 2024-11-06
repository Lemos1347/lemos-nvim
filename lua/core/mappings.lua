-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    -- switch between windows (without TMUX plugin)
    -- ["<C-h>"] = { "<C-w>h", "Window left" },
    -- ["<C-l>"] = { "<C-w>l", "Window right" },
    -- ["<C-j>"] = { "<C-w>j", "Window down" },
    -- ["<C-k>"] = { "<C-w>k", "Window up" },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },

    -- save
    ["<C-s>"] = { ":w<CR>", "Save file", opts = { silent = true } },
    -- ["<leader>w"] = { ":bp|bd#<CR>", "Close current buffer" },
    -- ["<leader>W"] = { ":%bd|e#<CR>", "Close all buffers except the one you are" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    ["<Tab>"] = { ":bnext<CR>", "Switch to next buffer." },
    ["<S-Tab>"] = { ":bprev<CR>", "Switch to previuous buffer" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "LSP formatting",
    },
    ["<leader>in"] = {
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      "LSP toogle inlay hint",
    },

    --window management
    ["<leader>sv"] = { "<C-w>v", "Split window vertically" }, -- split window vertically
    ["<leader>sh"] = { "<C-w>s", "Split window horizontally" }, -- split window horizontally
    ["<leader>se"] = { "<C-w>=", "Make splits equal size" }, -- make split windows equal width & height
    ["<leader>sx"] = { "<cmd>close<CR>", "Close current split" }, -- close current split window

    ["<leader>q"] = { ":q<CR>", "Exit current window" },
    ["d"] = { '"_d', "Delete without copyng" },
    ["c"] = { '"_c', "Delete and insert mode without copyng" },
    ["J"] = { "mzJ`z", "Append above line to current and maintaing cursor where it is" },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected text up" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected text down" },
    ["d"] = { '"_d', "Delete without copyng" },
    ["c"] = { '"_c', "Delete and insert mode without copyng" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    --[[ ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } }, ]]
    ["p"] = { '"_dP', "Replace without copying" },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Goto next",
    },

    ["<leader>d"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
    ["<leader>lsrs"] = {
      ":LspRestart<CR>",
      "Restart lsp",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>fe"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },

    ["<leader>er"] = { "<cmd>NvimTreeRefresh<CR>", "Refresh file explorer" },

    ["<leader>ec"] = { "<cmd>NvimTreeCollapse<CR>", "Collapse file explorer" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    ["<leader>cd"] = { "<cmd> Telescope zoxide list <CR>", "zoxide bookmarks" },

    --builtins
    ["<leader>wh"] = {
      function()
        require("telescope.builtin").keymaps()
      end,
      "List keymaps",
    },
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "List all lsp simbols",
    },
    ["<leader>ld"] = {
      function()
        require("telescope.builtin").diagnostics({ bufnr = 0 })
      end,
      "List lsp diagnostics for the current folder",
    },
    ["<leader>la"] = {
      function()
        require("telescope.builtin").diagnostics({ bufnr = 0 })
      end,
      "List lsp diagnostics for the current workspace",
    },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-I>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term",
    },

    ["<A-b>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-I>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term",
    },

    ["<A-b>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new("horizontal")
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new("vertical")
      end,
      "New vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd([[normal! _]])
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.formatting = {
  plugin = true,
  n = {
    ["<leader>mp"] = {
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      "Format file",
    },
  },
  v = {
    ["<leader>mp"] = {
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      "Format range",
    },
  },
}

M.undotree = {
  plugin = true,
  n = {
    ["<leader>z"] = { "<cmd>:UndotreeToggle|:UndotreeFocus<CR>", "Toggle undotree vision" },
  },
}

M.linting = {
  plugin = true,
  n = {
    ["<leader>l"] = {
      function()
        require("lint").try_lint()
      end,
      "Trigger linting for current file",
    },
  },
}

M.harpoon = {
  plugin = true,
  n = {

    ["<leader>a"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Add file to harpoon" },
    ["<C-e>"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Toogle menu" },

    ["<A-a>"] = {
      function()
        require("harpoon.ui").nav_file(1)
      end,
      "Go to file 1",
    },
    ["<A-s>"] = {
      function()
        require("harpoon.ui").nav_file(2)
      end,
      "Go to file 2",
    },
    ["<A-d>"] = {
      function()
        require("harpoon.ui").nav_file(3)
      end,
      "Go to file 3",
    },
    ["<A-f>"] = {
      function()
        require("harpoon.ui").nav_file(4)
      end,
      "Go to file 4",
    },
  },
}

--just for cheatsheet
M.surround = {
  plugin = true,
  n = {
    ["ysiw + <what_surround_with>"] = { "", "Surround word" },
    ["cs + <from> + <to>"] = { "", "Change surrounded" },
    ["ds + <from>"] = { "", "Deleted surrounded" },
  },
  v = {
    ["S"] = { "", "Surround selected" },
  },
}

M.barbar = {
  plugin = true,
  n = {
    ["<A-,>"] = { "<Cmd>BufferPrevious<CR>", "Move to previous", opts = { silent = true } },
    ["<A-.>"] = { "<Cmd>BufferNext<CR>", "Move to next", opts = { silent = true } },

    ["<A-<>"] = { "<Cmd>BufferMovePrevious<CR>", "Re-order to previous", opts = { silent = true } },
    ["<A->>"] = { "<Cmd>BufferMoveNext<CR>", "Re-order to next", opts = { silent = true } },

    ["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", "Go to buffer 1", opts = { silent = true } },
    ["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", "Go to buffer 2", opts = { silent = true } },
    ["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", "Go to buffer 3", opts = { silent = true } },
    ["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "Go to buffer 4", opts = { silent = true } },
    ["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "Go to buffer 5", opts = { silent = true } },
    ["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "Go to buffer 6", opts = { silent = true } },
    ["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "Go to buffer 7", opts = { silent = true } },
    ["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "Go to buffer 8", opts = { silent = true } },
    ["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "Go to buffer 9", opts = { silent = true } },
    ["<A-0>"] = { " <Cmd>BufferLast<CR>", "Go to last buffer", opts = { silent = true } },

    ["<A-p>"] = { "<Cmd>BufferPin<CR> ", "Pin/unpin buffer", opts = { silent = true } },

    ["<A-w>"] = { "<Cmd>BufferClose<CR>", "Close buffer", opts = { silent = true } },
    ["<A-t>"] = { "<Cmd>BufferRestore<CR>", "Restore buffer", opts = { silent = true } },
    ["<A-q>"] = {
      "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
      "Close all buffers except the one you are",
      opts = { silent = true },
    },
    ["<A-c->>"] = { "<Cmd>BufferCloseBuffersLeft<CR>", "Close buffers in the left", opts = { silent = true } },
    ["<A-c-<>"] = { "<Cmd>BufferCloseBuffersRight<CR>", "Close buffers in the right", opts = { silent = true } },

    ["<C-p>"] = { "<Cmd>BufferPick<CR>", "Magic buffer-picking mode", opts = { silent = true } },

    ["<leader>bb"] = {
      "<Cmd>BufferOrderByBufferNumber<CR>",
      "Order buffers by buffer number",
      opts = { silent = true },
    },
    ["<leader>bn"] = { "<Cmd>BufferOrderByName<CR>", "Order buffers by name", opts = { silent = true } },
    [" <leader>bd "] = { "<Cmd>BufferOrderByDirectory<CR>", "Order buffers by directory", opts = { silent = true } },
    ["<leader>bl"] = { "<Cmd>BufferOrderByLanguage<CR>", "Order buffers by language", opts = { silent = true } },
    ["<leader>bw"] = {
      "<Cmd>BufferOrderByWindowNumber<CR> ",
      "Oreder buffers by window number",
      opts = { silent = true },
    },
  },
}

M.spectre = {
  plugin = true,
  n = {
    ["<leader>sr"] = { '<cmd>lua require("spectre").toggle()<CR>', "Toggle Spectre" },
    ["<leader>sw"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "Search current word" },
    ["<leader>sp"] = {
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      "Search on current file",
    },
  },
  v = {
    ["<leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', "Search current word" },
  },
}

return M
