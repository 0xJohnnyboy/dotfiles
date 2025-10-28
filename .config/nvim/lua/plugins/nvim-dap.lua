return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap = require('dap')

        -- Set up signs for breakpoints
        vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
        vim.fn.sign_define('DapBreakpointCondition', { text='🟡', texthl='', linehl='', numhl='' })
        vim.fn.sign_define('DapBreakpointRejected', { text='🚫', texthl='', linehl='', numhl='' })
        vim.fn.sign_define('DapStopped', { text='▶️', texthl='', linehl='', numhl='' })
        vim.fn.sign_define('DapLogPoint', { text='📝', texthl='', linehl='', numhl='' })
    end
}
