{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  zshCompletions = "${pkgs.zsh-completions}/share/zsh/site-functions/";
  zshYouShouldUse =
    "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/";
  zshSyntaxHighlighting =
    "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/";
  zshAutoSuggestions = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/";
  zshHistorySearch =
    "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/";
in {
  config = {
    users.users.main.shell = pkgs.zsh;

    environment.systemPackages = with pkgs; [ exa starship ];

    programs.zsh = {
      enable = true;
      interactiveShellInit = ''
        fpath+="${zshCompletions}"
        fpath+="${zshSyntaxHighlighting}"
        source ${zshYouShouldUse}/you-should-use.plugin.zsh
        source ${zshSyntaxHighlighting}/fast-syntax-highlighting.plugin.zsh
        source ${zshAutoSuggestions}/zsh-autosuggestions.zsh
        source ${zshHistorySearch}/zsh-history-substring-search.zsh
      '';
    };
  };
}

