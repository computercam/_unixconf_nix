{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  zshAutoSuggestions = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
  zshCompletions = "${pkgs.zsh-completions}/share/zsh/site-functions";
  zshHistorySearch = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
  zshSyntaxHighlighting = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
  zshYouShouldUse = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
  cfg = config.cfg.shell;
in {
  imports = [
    ./options.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      zoxide
      starship
      bat
      exa
    ];

    programs.zsh = {
      enable = true;

      interactiveShellInit = ''
        ## START CUSTOM SETUP

        function pathIf () {
          [ -e "$1" ] && export PATH="$PATH:$1"
        }

        function sourceIf() {
          [ -e "$1" ] && source $1
        }

        function fpathIf() {
          [ -e "$1" ] && fpath=($1 $fpath)
        }

        fpathIf "${zshCompletions}"
        fpathIf "${zshSyntaxHighlighting}"

        sourceIf ${zshAutoSuggestions}/zsh-autosuggestions.zsh
        sourceIf ${zshHistorySearch}/zsh-history-substring-search.zsh
        sourceIf ${zshSyntaxHighlighting}/fast-syntax-highlighting.plugin.zsh
        sourceIf ${zshYouShouldUse}/you-should-use.plugin.zsh

        ### OH-MY-ZSH

        export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
        ${optionalString (cfg.ohMyZshPlugins != []) ''
          plugins=(${concatStringsSep " " cfg.ohMyZshPlugins})
        ''}
        source $ZSH/oh-my-zsh.sh
        
        ${optionalString (cfg.variables != {}) ''
          ### VARIABLES

          ${concatStringsSep "\n" 
              (lib.attrsets.mapAttrsToList 
                (name: value: ''${name}="${value}";'') 
                cfg.variables)}
        ''}

        ${optionalString (cfg.aliases != {}) ''
          ### ALIASES

          ${concatStringsSep "\n" 
              (lib.attrsets.mapAttrsToList 
                (name: value: ''alias ${name}="${value}";'') 
                cfg.aliases)}
        ''}

        ${optionalString (cfg.setOpts != []) ''
          ### OPTIONS

          setopt ${concatStringsSep "\nsetopt " cfg.setOpts}
        ''}

        ${optionalString (cfg.completions != {}) ''
          ### COMPLETIONS

          ${concatStringsSep "\n" 
              (lib.attrsets.mapAttrsToList 
                (name: value: ''zstyle ':completion:*' ${name} ${value}'') 
                cfg.completions)}
        ''}

        ${optionalString (cfg.keybindings != {}) ''
          ### KEYBINDINGS
          ## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
          ## showkey -a       # get keyboard keycodes
          ## zle -la | less   # get all possible commands
          ## bindkey          # get all currently bounded commands

          bindkey -e

          ${concatStringsSep "\n" 
              (lib.attrsets.mapAttrsToList 
                (name: value: ''bindkey '${value}' ${name}'') 
                cfg.keybindings)}
        ''}               
      
        ## END CUSTOM SETUP
      '';

      promptInit = ''
        ## START PROMPTINIT

        eval "$(${pkgs.starship}/bin/starship init zsh)"
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

        ## END PROMPTINIT
      '';
    };
  };
}

