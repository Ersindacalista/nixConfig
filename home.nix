{ config, pkgs, ...}:

{
    home.username = "gabriele";
    home.homeDirectory = "/home/gabriele";
    
    home.stateVersion = "25.11";
    programs.bash = {
        enable = true;
        shellAliases = {
            prova = "echo i use nixos btw";
        };
        profileExtra = ''
           if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
               exec start-hyprland
           fi
        ''; 
    };
    home.packages = with pkgs; [
        gruvbox-gtk-theme
        lyra-cursors
        dracula-icon-theme 
    ];
    home.pointerCursor = {
      package = pkgs.lyra-cursors;
      name = "LyraB-cursors";
      size = 12;
      gtk.enable = true;
      x11.enable = true;
    };
    gtk = {
      enable = true;

      theme = {
          name = "Gruvbox-Dark";  
          package = pkgs.gruvbox-gtk-theme;
      };

      cursorTheme = {
          name = "LyraB-cursors";
          package = pkgs.lyra-cursors;
      };
      iconTheme = {
          name = "Dracula";
          package = pkgs.dracula-icon-theme;
      };
    };
}
