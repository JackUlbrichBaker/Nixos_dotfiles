{ config, input, pkgs, ... }:

{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "JackUlbrichBaker";
    userEmail = "jackubaker@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # config gh to use ssh
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = ''
            bind s split-window -h      
            bind v split-window -v
            setw -g window-status-format #[bg=NONE]#[fg=colour240] #I #[bg=NONE]#[fg=colour240] #W "
            setw -g window-status-current-format "#[fg=colour246]#[bg=NONE] #I #[bg=NONE]#[fg=colour246] #W#F "

            bind < resize-pane -L 10
            bind > resize-pane -R 10
            bind + resize-pane -U 5
            bind - resize-pane -D 5

      # Activity
            set -g monitor-activity on
            set -g visual-activity on

      ### Status Bar Design ###
            set -g status-style bg=default
            set -g status-style fg=white
            set -g window-status-activity-style fg=black 
            set -g window-status-activity-style bold
            set -g pane-active-border-style fg=colour79

      # Tmux message prompt
            set -g message-style fg=colour209 
            set -g message-style bold
            set -g message-style bg=colour16

            set -g status-justify centre
            set -g status-left '#[fg=colour221,bold]   #S '
            set -g window-status-format "#[fg=colour79] #I #W "
            set -g window-status-current-format "#[fg=colour74,bg=colour16,bold] #I #W "
            set -g status-right '#[fg=colour209]%a %b %d ' # %l:%M %p'


      # Colorscheme
            set -g @catppuccin_flavour 'mocha'

    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
            export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

            function mkcd ()
            {
      	command mkdir $1 && cd $1
            }
          if [ -z "$TMUX" ]; then tmux; fi
            fastfetch 
      	'';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      rebuild = "sudo nixos-rebuild switch --flake /home/jack/dotfiles/nixos/#default";
    };
  };
}
