{ config, pkgs, ... }:

{
  home.username = "will";
  home.homeDirectory = "/home/will";

  home.stateVersion = "25.05"; # Do not change when updating home manager

  home.file = { };

  home.packages = [
    pkgs.curl
    pkgs.rustup
    pkgs.ruby
    pkgs.python3
    pkgs.go
    pkgs.nodejs
    pkgs.scala
    pkgs.php
    pkgs.nmap
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    shellAliases = {
      bs = "sudo /nix/var/nix/profiles/default/bin/nix run 'github:numtide/system-manager' -- switch --flake '~/.config/system-manager'";
      bh = "home-manager switch";
      es = "nvim ~/.config/system-manager/system.nix";
      eh = "nvim ~/.config/home-manager/home.nix";
      vi = "nvim";
    };
    initContent = ''
      [ -f "${pkgs.oh-my-zsh}/share/oh-my-zsh.sh" ] && source "${pkgs.oh-my-zsh}/share/oh-my-zsh.sh"

      bindkey -v

      [ -f ~/.nix-profile/share/fzf/completion.zsh ] && source ~/.nix-profile/share/fzf/completion.zsh
      [ -f ~/.nix-profile/share/fzf/key-bindings.zsh ] && source ~/.nix-profile/share/fzf/key-bindings.zsh
      bindkey '^R' fzf-history-widget
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
  	enable = true;
  	plugins = [ pkgs.vimPlugins.lazy-nvim ];
    extraConfig = ''
      set tabstop=2 softtabstop=2 shiftwidth=2
      set expandtab
      set number ruler
      set autoindent smartindent
      syntax enable
      filetype plugin indent on
    '';
    extraLuaConfig = ''
      require("lazy").setup({
        rocks = { enabled = false },
        pkg = { enabled = false },
        install = { missing = false },
        change_detection = { enabled = false },
        spec = {
          -- TODO
        },
      })
    '';
  };

  programs.git = {
    enable = true;
    userName = "Will Harrison";
    userEmail = "will@jwh.io";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Host *
        AddKeysToAgent yes
    '';
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519-will";
      };
    };
  };
}
