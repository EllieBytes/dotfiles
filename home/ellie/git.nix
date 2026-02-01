{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Ellie Johnston";
        email = "jellie7118@proton.me";
      };

      credential.helper = "store";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
