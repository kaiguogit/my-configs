local autosave = require('autosave')
autosave.setup(
    {
        prompt_style = 'stdout',
        events = {
            'TextChanged'
        },
        debounce_delay = 3000
    }
)
