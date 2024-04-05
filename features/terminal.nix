{  pkgs,  ... }:

let
    overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
    libPath = with pkgs; lib.makeLibraryPath [
      # load external libraries that you need in your rust project here
    ];
in
  {
  pkgs.mkShell = {
    buildInputs = with pkgs; [
      clang
      # Replace llvmPackages with llvmPackages_X, where X is the latest LLVM version (at the time of writing, 16)
      llvmPackages_16.bintools
      rustup
    ];

    RUSTC_VERSION = overrides.toolchain.channel;
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
    shellHook = ''
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
      '';
    RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
      # add libraries here (e.g. pkgs.libvmi)
    ]);

  };

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
      rebuild = "sudo nixos-rebuild switch --flake /home/jack/dotfiles/nixos/#default";
    };
  };
}
