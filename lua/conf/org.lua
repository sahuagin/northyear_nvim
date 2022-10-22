vim.cmd.packadd { 'orgmode', bang = true }

require('orgmode').setup_ts_grammar()

local org_dir = '~/Desktop/orgmode'

local bubble_tea_template = function(opts)
    local template = '** %U %?'
    if opts.level then
        local additional_heading_levels = string.rep('*', opts.level - 2)
        template = additional_heading_levels .. template
    end
    return {
        target = org_dir .. '/capture/bubble_tea_live.org',
        template = opts.template or template,
        description = opts.description,
        headline = opts.headline,
    }
end

require('orgmode').setup {
    org_agenda_files = { org_dir .. '/*', org_dir .. '/**/*' },
    org_default_notes_file = org_dir .. '/capture/todo.org',
    org_highlight_latex_and_related = 'native',
    org_todo_keywords = { 'TODO(t)', 'STRT', 'WAIT', 'HOLD', '|', 'DONE', 'KILL' },
    win_split_mode = 'auto',
    org_hide_leading_stars = true,
    org_hide_emphasis_markers = true,

    org_capture_templates = {
        t = { description = 'personal todo', template = '* TODO %? :\nSCHEDULED: %t' },
        n = {
            description = 'personal notes',
            template = '* %u %?\n%x\n%a',
            target = org_dir .. '/capture/notes.org',
        },
        j = {
            description = 'applied jobs',
            template = '- [ ] %? %u',
            headline = 'Applied jobs',
        },

        b = 'bubble tea',
        bf = bubble_tea_template {
            description = 'feed food',
            headline = 'feed food',
        },
        bw = bubble_tea_template {
            description = 'feed water',
            headline = 'feed water',
        },
        bp = bubble_tea_template {
            description = 'poop',
            headline = 'poop',
        },
        bP = bubble_tea_template {
            description = 'play',
            headline = 'play',
        },
        be = bubble_tea_template {
            description = 'eye mucus',
            headline = 'eye mucus',
            level = 3,
        },
        bE = bubble_tea_template {
            description = 'ear clean',
            headline = 'ear clean',
            level = 3,
        },
        bb = bubble_tea_template {
            description = 'bath',
            headline = 'bath',
            level = 3,
        },
        bt = bubble_tea_template {
            description = 'trim coat',
            headline = 'trim coat',
            level = 3,
        },
        bg = bubble_tea_template {
            description = 'grooming',
            headline = 'grooming',
            level = 3,
        },
        bn = bubble_tea_template {
            description = 'nailing',
            headline = 'nailing',
            level = 3,
        },
        bB = bubble_tea_template {
            description = 'brushing teeth',
            headline = 'brushing teeth',
            level = 3,
        },
        bs = bubble_tea_template {
            description = 'symptom',
            headline = 'symptom',
        },
    },

    mappings = {
        prefix = '<Leader>o',

        global = {
            org_agenda = '<prefix>a',
            org_capture = '<prefix>c',
        },

        capture = {
            org_capture_finalize = '<C-c><C-c>',
            org_capture_refile = '<C-c><C-r>',
            org_capture_kill = '<C-c><C-k>',
            org_capture_show_help = 'g?',
        },

        org = {
            org_todo = '<LocalLeader>t',
            org_toggle_checkbox = '<LocalLeader>x',
        },

        text_objects = {
            inner_heading = 'ih',
            around_heading = 'ah',
            inner_subtree = 'ir',
            around_subtree = 'ar',
            inner_heading_from_root = 'iH',
            around_heading_from_root = 'aH',
            inner_subtree_from_root = 'iR',
            around_subtree_from_root = 'aR',
        },
    },
}

local my_augroup = require('conf.builtin_extend').my_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
    pattern = 'org',
    desc = 'set cursorline for org filetype',
    group = my_augroup,
    command = 'setlocal cursorline',
})
