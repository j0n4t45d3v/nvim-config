return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'bufwinenter',
    config = function()
        require('lualine').setup {}
    end
}
