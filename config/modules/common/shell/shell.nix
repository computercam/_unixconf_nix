{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  cfg = config.cfg.shell;
in {
  imports = [ 
    ./modules.nix 
    ./options.nix
  ];

  config.home-manager.users."${config.cfg.user.name}" = {
    programs.zsh = {
      enable = true;

      initExtra = ''
        function pathIf () {
          [ -e "$1" ] && export PATH="$PATH:$1"
        }

        function sourceIf() {
          [ -e "$1" ] && source $1
        }

        function fpathIf() {
          [ -e "$1" ] && fpath=($1 $fpath)
        }

        ${optionalString (cfg.fpaths != []) ''
          ### FUNCTION PATHS

          fpathIf ${concatStringsSep "\nfpathIf " cfg.fpaths}
        ''}

        ${optionalString (cfg.sources != []) ''
          ### SOURCES

          sourceIf ${concatStringsSep "\nsourceIf " cfg.sources}
        ''}

        ${optionalString (cfg.paths != []) ''
          ### PATHS

          pathIf ${concatStringsSep "\npathIf " cfg.paths}
        ''}  

        ${optionalString (cfg.ohMyZsh.enable == true) ''
          ### OH-MY-ZSH
          
          export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
          
          ${optionalString (cfg.ohMyZsh.plugins != []) ''
            plugins=(${concatStringsSep " " cfg.ohMyZsh.plugins})
          ''}

          source $ZSH/oh-my-zsh.sh
        ''}
        
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

        ${optionalString (cfg.extras != []) ''
          ### EXTRAS

          ${concatStringsSep "\n" cfg.extras}
        ''}       
      '';
    };
  };
}

