{ inputs, lib, config, pkgs, extensions, ... }:
{
  # XDG
  xdg.menus.enable = true;
  xdg.mime = {
    enable = true;
    addedAssociations = {
      "application/pdf" = "zen.desktop";
      "text/*" = [
        "Helix.desktop"
        "codium.desktop"
      ];
      "audio/*" = [
        "vlc.desktop"
        "mpv.desktop"
        "umpv.desktop"
      ];

      "inode/directory" = "org.kde.dolphin.desktop";
      "application/x-directory" = "org.kde.dolphin.desktop";
      "x-scheme-handler/file" = "org.kde.dolphin.desktop";

      "application/x-xz-compressed-tar" = "org.kde.ark.desktop";
      "application/zip" = "org.kde.ark.desktop";

      "x-scheme-handler/jetbrains" = "idea.desktop";
    };
    defaultApplications = {
      "application/x-extension-htm" = "zen.desktop";
      "application/x-extension-html" = "zen.desktop";
      "application/x-extension-shtml" = "zen.desktop";
      "application/x-extension-xht" = "zen.desktop";
      "application/x-extension-xhtml" = "zen.desktop";
      "application/pdf" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";

      #"application/zip" = "ark-2.desktop";
      #"application/x-xz-compressed-tar" = "ark.desktop";
      
      "text/*" = "Helix.desktop";

      "image/*" = "qimgv.desktop";

      "video/*" = "vlc.desktop";
      "audio/*" = "vlc.desktop";

      "inode/directory" = "org.kde.dolphin.desktop";
      "application/x-directory" = "org.kde.dolphin.desktop";
      "x-scheme-handler/file" = "org.kde.dolphin.desktop";

      "application/x-xz-compressed-tar" = "org.kde.ark.desktop";
      "application/zip" = "org.kde.ark.desktop";
            
      "x-scheme-handler/adskidmgr" = "adskidmgr-opener.desktop";
      "x-scheme-handler/chrome" = "zen.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/jetbrains" = "jetbrains-toolbox.desktop";
      "x-scheme-handler/discord-1216669957799018608" = "discord-1216669957799018608.desktop";
    };
  };
}
