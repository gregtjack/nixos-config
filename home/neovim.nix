{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    globals.mapleader = " ";

    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<C-p>" = {
            action = "git_files";
            options.desc = "git files";
          };
          "<leader>f" = "live_grep";
        };
        extensions.fzf-native.enable = true;
      };

      luasnip.enable = true;
      treesitter.enable = true;
      lualine.enable = true;

      # rust lsp and tools
      rustaceanvim.enable = true;

      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          html.enable = true;
          lua-ls.enable = true;
          ocamllsp.enable = true;
          gopls.enable = true;
          ccls.enable = true;
        };
      };

      mini = {
        enable = true;
        # Enable and configure the mini modules. The keys are the names of the modules
        # (without the mini. prefix). The value is an attrs of configuration options for
        # the module. Leave the attrs empty to use the module’s default configuration.
        modules = {
          files = {};
          bracketed = {};
          notify = {};
          diff = {};
          git = {};
          surround = {};
          tabline = {};
          comment = {};
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
          "<S-Tab>" = ''
               cmp.mapping(function(fallback)
                 if cmp.visible() then
            local entries = cmp.get_entries()
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })

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
