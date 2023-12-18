return {
  -- file explorer
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      }
    }
  }
}
