require("session_manager").setup({
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = false,                                           -- Automatically save last session on exit.
})
