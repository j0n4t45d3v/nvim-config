return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local keymap = require("core.keymap");
    local key = keymap.key
    local opt = keymap.opt

    harpoon:setup()

    key.set(
      "n",
      "<leader>ha",
      function() harpoon:list():add() end,
      opt("[H]arpoon [A]dd")
    )
    key.set(
      "n",
      "<leader>hl",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      opt("[H]arpoon [L]ist")
    )

    key.set(
      "n", 
      "<leader>h1",
      function() harpoon:list():select(1) end, 
      opt("[H]arpoon Select [1]")
    )
    key.set(
      "n",
      "<leader>h2",
      function() harpoon:list():select(2) end,
      opt("[H]arpoon Select [2]")
    )
    key.set(
      "n",
      "<leader>h3",
      function() harpoon:list():select(3) end,
      opt("[H]arpoon Select [3]")
    )
    key.set(
      "n",
      "<leader>h4",
      function() harpoon:list():select(4) end,
      opt("[H]arpoon Select [4]")
    )

    -- Toggle previous & next buffers stored within Harpoon list
    key.set(
      "n",
      "<leader>hp",
      function() harpoon:list():prev() end,
      opt("[H]arpoon [P]rev")
    )
    key.set(
      "n",
      "<leader>hn",
      function() harpoon:list():next() end,
      opt("[H]arpoon [N]ext")
    )
  end
}
