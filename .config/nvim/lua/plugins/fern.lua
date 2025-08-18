return {
    'lambdalisue/fern.vim',
    dependencies = {
        'lambdalisue/fern-hijack.vim',
        'lambdalisue/nerdfont.vim',
        'lambdalisue/fern-renderer-nerdfont.vim',
        'lambdalisue/fern-git-status.vim',
        {
            'yuki-yano/fern-preview.vim',
            keys = {
                { 'p',     '<Plug>(fern-action-preview:toggle)',           ft = "fern" },
                { '<C-j>', '<Plug>(fern-action-preview:scroll:down:half)', ft = "fern" },
                { '<C-k>', '<Plug>(fern-action-preview:scroll:up:half)',   ft = "fern" },
                { '<C-o>', '<Plug>(fern-action-open:select)',              ft = "fern" },
                { '<C-v>', '<Plug>(fern-action-open:vsplit)',              ft = "fern" },
                { 'n',     '<Plug>(fern-action-new-path)',                 ft = "fern" },
                { 'r',     '<Plug>(fern-action-rename)',                   ft = "fern" },
                { 'm',     '<Plug>(fern-action-move)',                     ft = "fern" },
                { 'c',     '<Plug>(fern-action-copy)',                     ft = "fern" },
                { 't',     '<Plug>(fern-action-remove)',                   ft = "fern" },
                { ',',     '<Plug>(fern-action-mark:toggle)',              ft = "fern" },
                { 'd',     '<Plug>(fern-action-diff)',                     ft = "fern" },
                { 'H',     '<Plug>(fern-action-hidden-toggle)',            ft = "fern" },
                { 'h',     '<Plug>(fern-action-collapse)',                 ft = "fern" },
                { '-',     '<Plug>(fern-action-cd)',                       ft = "fern" }
            }
        }
    }
}
