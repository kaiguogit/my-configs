local autosave = require('autosave')
autosave.setup(
    {
        enable = true,
        prompt_style = 'stdout',
        events = {
            'TextChanged'
        },
        debounce_delay = 3000
    }
)
