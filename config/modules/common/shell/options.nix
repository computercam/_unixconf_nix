{ lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib; {
  options.cfg.shell = {
    ohMyZshPlugins = mkOption {
      type = types.listOf types.str;
      default = [ "git" ];
      description = "list of oh-my-zsh plugins to use";
    };

    variables = mkOption {
      type = with types; attrsOf (nullOr (either str path));
      default = {
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
      description = "Attrset of varibles";
    };

    aliases = mkOption {
      type = with types; attrsOf (nullOr (either str path));
      default = {
        cat = "${pkgs.bat}/bin/bat";
        cd = "z";
        less = "${pkgs.bat}/bin/bat";
        ls = "${pkgs.exa}/bin/exa --icons -h";
      };
      description = "Attrset of aliases";
    };

    setOpts = mkOption {
      type = types.listOf types.str;
      default = [
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
      description = "List of set options";
    };

    completions = mkOption {
      type = with types; attrsOf (nullOr (either str path));
      default = {
        accept-exact = "'*(N)'";
        cache-path = "~/.zsh/cache";
        list-colors = ''"\$\{(s.:.)LS_COLORS\}"'';
        matcher-list = "'m:{a-zA-Z}={A-Za-z}'";
        rehash = "true";
        use-cache = "on";
      };
      description = "Attrset of zstyle zsh completions";
    };

    keybindings = mkOption {
      type = with types; attrsOf (nullOr (either str path));
      default = {
        delete-char = "\\e[3~"; # delete
        forward-char = "^[[c"; # right key
        backward-char = "^[[d"; # left key
        forward-word = "^[[1;5C"; # ctrl + right
        backward-word = "^[[1;5D"; # ctrl + left
        backward-kill-word = "^[[1;7D"; # ctrl + alt + left
        kill-word = "^[[1;7C"; # ctrl + alt + right
        history-substring-search-down = "^[[B"; # down arrow history substring search
        history-substring-search-up = "^[[A"; # up arrow history substring search
        beginning-of-line = "^[[H"; # [Home] - Go to beginning of line
        end-of-line = "^[[F"; # [End] - Go to end of line
      };
      description = "Attrset of zsh bindkey keybindings";
    };

    paths = mkOption {
      type = types.listOf types.str;
      default = [
        "$HOME/scripts"
        "$HOME/.node_modules/bin"
        "$HOME/.cargo/bin"
        "$HOME/.local/bin"
        "/usr/local/bin"
        "/usr/libexec/java_home"
      ];
      description = "List of paths to add to your $PATH";
    };


  };
}
