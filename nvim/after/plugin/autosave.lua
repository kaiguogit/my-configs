local autosave = require('autosave')
autosave.setup(
    {
        events = {
            'TextChanged'
        },
        debounce_delay = 3000
    }
)
