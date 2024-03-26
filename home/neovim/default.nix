{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    globals.mapleader = " ";

    plugins = {
      lualine.enable = true;
      
      telescope = {
	enable = true;
	keymaps = {
	  "<C-p>" = {
	    action = "git_files";
	    desc = "git files";
	  };
	  "<leader>f" = "live_grep";
	};
	extensions.fzf-native.enable = true;
      };

      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      # rust lsp and tools
      rustaceanvim.enable = true;
      
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
	  ocamllsp.enable = true;
       };
      };

      cmp = {
	enable = true;
	autoEnableSources = true;
	settings.sources = [
	 {name = "nvim_lsp";}
	 {name = "path";}
	 {name = "buffer";}
	 {name = "luasnip";}
	];

	settings.snippet.expand = ''
	  function(args)
	    require('luasnip').lsp_expand(args.body)
	  end
	'';

	settings.mapping = {
	 "<CR>" = "cmp.mapping.confirm({ select = true })";
	 "<Tab>" = ''
	    cmp.mapping(function(fallback)
	      if cmp.visible() then
		local entries = cmp.get_entries()
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })

		if #entries == 1 then
		  cmp.confirm()
		end
	      else
		fallback()
	      end
	    end, { "i", "s" })
	  '';
	};
      };
    };
  };
}
