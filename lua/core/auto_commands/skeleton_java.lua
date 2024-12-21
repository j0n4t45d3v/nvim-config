vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    -- Caminho do arquivo e transformação para pacote
    local filepath = vim.fn.expand("%:p:h")
    local package = filepath:match("src/(.+)$") or filepath:match("test/(.+)$") or "default.package"
    package = package:gsub("/", ".")
    package = package:gsub("main.java", "")
    package = package:gsub("test.java", "")

    -- Nome da classe a partir do nome do arquivo
    local class_name = vim.fn.expand("%:t:r")

    -- Inserindo o template
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
      "package " .. package .. ";",
      "",
      "public class " .. class_name .. " {",
      "    public " .. class_name .. "() {",
      "        // Constructor",
      "    }",
      "}",
    })
    vim.cmd("normal! 4k")
  end,
})
