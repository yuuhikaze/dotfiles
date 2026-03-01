require("competitest").setup {
    testcases_use_single_file = true,
    template_file = vim.fn.stdpath("config") .. "/lua/plugins/config/competitest/template.$(FEXT)",
    evaluate_template_modifiers = true,
    compile_command = {
        c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT).out" } },
        cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT).out" } },
        rust = { exec = "rustc", args = { "$(FNAME)" } },
        zig = { exec = "zig", args = { "build-exe", "-O", "ReleaseFast", "-femit-bin=$(FNOEXT).out", "$(FNAME)" } },
        java = { exec = "javac", args = { "$(FNAME)" } },
    },
    run_command = {
        c = { exec = "./$(FNOEXT).out" },
        cpp = { exec = "./$(FNOEXT).out" },
        rust = { exec = "./$(FNOEXT)" },
        zig = { exec = "./$(FNOEXT).out" },
        python = { exec = "python", args = { "$(FNAME)" } },
        java = { exec = "java", args = { "$(FNOEXT)" } },
    },
    submit = {
        kattis = {
            config_file = vim.fn.expand('~/.kattisrc'),
        },
    },
}
