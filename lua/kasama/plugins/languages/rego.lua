return {
	init = function(use)
    use('tsandall/vim-rego')
	end,
	lsp = function(setup_lsp)
		setup_lsp("pyright", {})
		setup_lsp("pylsp", {})
	end,
}
