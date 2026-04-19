local M = {}

function M.setup()
  local state = {
    buf = nil,
    win = nil,
  }

  local function is_valid_buf(buf) return buf and vim.api.nvim_buf_is_valid(buf) end

  local function is_valid_win(win) return win and vim.api.nvim_win_is_valid(win) end

  local function toggle_copilot()
    if is_valid_win(state.win) then
      vim.api.nvim_win_close(state.win, true)
      state.win = nil
      return
    end

    vim.cmd 'botright vsplit'
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(state.win, 50)

    if is_valid_buf(state.buf) then
      vim.api.nvim_win_set_buf(state.win, state.buf)
    else
      vim.cmd 'terminal'
      state.buf = vim.api.nvim_get_current_buf()
      local job_id = vim.b[state.buf].terminal_job_id
      vim.api.nvim_chan_send(job_id, 'copilot\n')
    end

    vim.cmd 'startinsert'
  end

  vim.api.nvim_create_user_command('ToggleCopilotTerm', toggle_copilot, {})
  vim.keymap.set('n', '<leader>tc', toggle_copilot, { desc = 'Toggle copilot terminal' })
end

return M
