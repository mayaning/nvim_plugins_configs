-- bookmarks配置
--
return {
  "LintaoAmons/bookmarks.nvim",
  -- tag = "v0.5.4", -- optional, pin the plugin at specific version for stability
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
  },
  config = function()
    local opts = {
      -- where you want to put your bookmarks db file (a simple readable json file, which you can edit manually as well)
      json_db_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/bookmarks.db.json"),
      -- This is how the sign looks.
      signs = {
        mark = { icon = "󰃁", color = "red", line_bg = "#572626" },
      },
      picker = {
        -- choose built-in sort logic by name: string, find all the sort logics in `bookmarks.adapter.sort-logic`
        -- or custom sort logic: function(bookmarks: Bookmarks.Bookmark[]): nil
        sort_by = "last_visited",
      },
      -- optional, backup the json db file when a new neovim session started and you try to mark a place
      -- you can find the file under the same folder
      enable_backup = true,
      -- optional, show the result of the calibration when you try to calibrate the bookmarks
      show_calibrate_result = true,
      -- optional, auto calibrate the current buffer when you enter it
      auto_calibrate_cur_buf = true,
      -- treeview options
      treeview = {
        bookmark_format = function(bookmark)
          return bookmark.name
            .. " ["
            .. bookmark.location.project_name
            .. "] "
            .. bookmark.location.relative_path
            .. " : "
            .. bookmark.content
        end,
        keymap = {
          quit = { "q", "<ESC>" },
          refresh = "R",
          create_folder = "a",
          tree_cut = "x",
          tree_paste = "p",
          collapse = "o",
          delete = "d",
          active = "s",
          copy = "c",
        },
      },
      -- do whatever you like by hooks
      hooks = {
        {
          ---a sample hook that change the working directory when goto bookmark
          ---@param bookmark Bookmarks.Bookmark
          ---@param projects Bookmarks.Project[]
          callback = function(bookmark, projects)
            local project_path
            for _, p in ipairs(projects) do
              if p.name == bookmark.location.project_name then
                project_path = p.path
              end
            end
            if project_path then
              vim.cmd("cd " .. project_path)
            end
          end,
        },
      },
    }
    require("bookmarks").setup(opts)
  end,
  keys = {
    { "mm", mode = { "n", "v" }, "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." } },
    { "mo", mode = { "n", "v" }, "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" } },
    { "ma", mode = { "n", "v" }, "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." } },
    { "mg", mode = { "n", "v" }, "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" } },
  },
}
