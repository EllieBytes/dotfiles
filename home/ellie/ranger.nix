{ pkgs, ... }:

{
  programs.ranger = {
    enable = true;
    rifle = [
      { condition = "image/*"; command = "${pkgs.qimgv}/bin/qimgv -- \"$@\""; }
      { condition = "application/pdf"; command = "${pkgs.zathura}/bin/zathura -- \"$@\""; }

      { condition = "else, flag f"; command = "xdg-open \"$@\""; }
    ];
  };
}
