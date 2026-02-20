return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    default = {
      dir_path = function()
        return vim.fs.dirname(vim.api.nvim_buf_get_name(0)) .. '/images'
      end,
      extension = 'png',
      file_name = '%Y%m%d-%H%M%S',
      use_absolute_path = false,
      relative_to_current_file = true,
      verbose = true,
      insert_mode_after_paste = true,
      prompt_for_file_name = true,
      show_dir_path_in_prompt = true,
      download_images = true,
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = '![$CURSOR]($FILE_PATH)',
      },
      tex = {
        template = [[
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
        ]],
      },
    },
  },
  keys = {
    { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from clipboard' },
    {
      '<leader>P',
      function()
        require('img-clip').paste_image { use_absolute_path = true }
      end,
      desc = 'Paste image with absolute path',
    },
    { '<leader>id', '<cmd>ImgClipDebug<cr>', desc = 'Show img-clip debug info' },
    { '<leader>ic', '<cmd>ImgClipConfig<cr>', desc = 'Show img-clip config' },
  },
}
