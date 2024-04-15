{ config, input,  pkgs,  ... }:

{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "JackUlbrichBaker"; userEmail = "jackubaker@gmail.com";
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


  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      
      function mkcd ()
      {
        command mkdir $1 && cd $1
      }

      neofetch | lolcat
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      ls = "tree";
      rebuild = "sudo nixos-rebuild switch --flake /home/jack/dotfiles/nixos/#default";
    };
  };
}
