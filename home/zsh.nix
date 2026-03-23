{ inputs, lib, config, pkgs, extensions, ... }:
{

  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "zen";
    TERMINAL = "kitty";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" "docker-compose" "fzf" ];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        #{ name = "marlonrichert/zsh-autocomplete"; }
      ];
    };
    #zprof.enable = true;

    syntaxHighlighting.enable = true;
    initContent = ''
      # Skip compaudit for faster startup (only if you trust your system)
      #ZSH_DISABLE_COMPFIX=true
    
      # Optimize completion
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$HOME/.zsh/cache"i
      
      eval "$(niri completions zsh)"
      eval "$(direnv hook zsh)"
    '';
  
      # Speed optimizations
    completionInit = "autoload -Uz compinit && compinit -C";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };
}
