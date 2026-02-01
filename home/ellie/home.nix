{ pkgs, ... }:

{
  imports = [
    ./waybar.nix
    ./swayfx/default.nix
    ./browser.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    font-awesome nerd-fonts.fira-code dseg7-full dseg14-full
  ];

  home.stateVersion = "25.11";
}
