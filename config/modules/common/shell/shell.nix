{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  zshAutoSuggestions = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/";
  zshCompletions = "${pkgs.zsh-completions}/share/zsh/site-functions/";
  zshHistorySearch = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/";
  zshSyntaxHighlighting = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/";
  zshYouShouldUse = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/";
in {
  # TODO: Consider refactoring this file and utils.nix
  config = {
    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      starship # rust alt - prompt # https://github.com/starship/starship
      stow
      neofetch
      htop
    ];

    environment.shellAliases = {
      # du = "${pkgs.dua}/bin/dua"; # dua
      # htop = "${pkgs.bottom}/bin/btm"; # bottom
      # iftop = "sudo ${pkgs.bandwhich}/bin/bandwhich"; # bandwhich
      # neofetch = "${pkgs.macchina}/bin/macchina"; # maccina
      cat = "${pkgs.bat}/bin/bat"; # bat
      cd = "z"; # zoxide
      less = "${pkgs.bat}/bin/bat"; # bat
      ls = "${pkgs.exa}/bin/exa"; # exa
      ranger = "${pkgs.joshuto}/bin/joshuto"; # joshuto
    };

    environment.variables = {
      LESS_TERMCAP_mb = "$(tput bold; tput setaf 2)";
      LESS_TERMCAP_md = "$(tput bold; tput setaf 6)";
      LESS_TERMCAP_me = "$(tput sgr0)";
      LESS_TERMCAP_mh = "$(tput dim)";
      LESS_TERMCAP_mr = "$(tput rev)";
      LESS_TERMCAP_se = "$(tput rmso; tput sgr0)";
      LESS_TERMCAP_so = "$(tput bold; tput setaf 3; tput setab 4)";
      LESS_TERMCAP_ue = "$(tput rmul; tput sgr0)";
      LESS_TERMCAP_us = "$(tput smul; tput bold; tput setaf 7)";
      LESS_TERMCAP_ZN = "$(tput ssubm)";
      LESS_TERMCAP_ZO = "$(tput ssupm)";
      LESS_TERMCAP_ZV = "$(tput rsubm)";
      LESS_TERMCAP_ZW = "$(tput rsupm)";
      LESS = "--RAW-CONTROL-CHARS";
      TERM = "xterm-256color";
    };

    programs.zsh = {
      enable = true;

      enableGlobalCompInit = false;

      interactiveShellInit = ''
        ### FUNCTIONS

        function pathIf () {
          [ -e "$1" ] && export PATH="$PATH:$1"
        }
        function sourceIf() {
          [ -e "$1" ] && source $1
        }
        function fpathIf() {
          [ -e "$1" ] && fpath=($1 $fpath)
        }

        ### IMPORTS

        fpathIf "${zshCompletions}"
        fpathIf "${zshSyntaxHighlighting}"

        sourceIf ${zshAutoSuggestions}/zsh-autosuggestions.zsh
        sourceIf ${zshHistorySearch}/zsh-history-substring-search.zsh
        sourceIf ${zshSyntaxHighlighting}/fast-syntax-highlighting.plugin.zsh
        sourceIf ${zshYouShouldUse}/you-should-use.plugin.zsh

        ### ZSTYLE

        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' cache-path ~/.zsh/cache
        zstyle ':completion:*' list-colors "\$\{(s.:.)LS_COLORS\}"
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' use-cache on

        ### KEYBINDINGS
        ## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
        ## showkey -a       # get keyboard keycodes
        ## zle -la | less   # get all possible commands
        ## bindkey          # get all currently bounded commands

        bindkey -e
        bindkey '\e[3~'        delete-char                    # delete
        bindkey '^[[c'         forward-char                   # right key
        bindkey '^[[d'         backward-char                  # left key
        bindkey '^[[1;5C'      forward-word                   # ctrl + right
        bindkey '^[[1;5D'      backward-word                  # ctrl + left
        bindkey '^[[1;7D'      backward-kill-word             # ctrl + alt + left
        bindkey '^[[1;7C'      kill-word                      # ctrl + alt + right
        bindkey "^[[B"         history-substring-search-down  # down arrow history substring search
        bindkey "^[[A"         history-substring-search-up    # up arrow history substring search
        bindkey "^[[H"         beginning-of-line              # [Home] - Go to beginning of line
        bindkey "^[[F"         end-of-line                    # [End] - Go to end of line
      '';

      # TODO: consider removing duplicated behavior from setOptions

      setOptions = [
        "AUTOCD"
        "AUTOPUSHD"
        "COMPLETE_ALIASES"
        "CORRECT"
        "EXTENDED_HISTORY"
        "EXTENDEDGLOB"
        "HIST_EXPIRE_DUPS_FIRST"
        "HIST_FCNTL_LOCK"
        "HIST_IGNORE_DUPS"
        "HIST_IGNORE_SPACE"
        "NOBEEP"
        "NOCASEGLOB"
        "NOCHECKJOBS"
        "NUMERICGLOBSORT"
        "PROMPT_SUBST"
        "RCEXPANDPARAM"
        "SHARE_HISTORY"
      ];

      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };

      promptInit = ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      '';
    };
  };
}

