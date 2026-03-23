{ inputs, lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kanata
  ];

  # Kanata
  boot.kernelModules = [ "uinput" ];

   # Enable uinput
  hardware.uinput.enable = true;

  # Ensure the uinput group exists
  users.groups.uinput = { };

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-id/usb-ROCCAT_ROCCAT_Vulcan_Pro-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
        (defsrc
          caps
          esc
          grv
        )

        (defalias
          escctrl (tap-hold 100 100 esc lctrl)
        )

        (deflayer base
          @escctrl
          f12
          Numpad8
        )
        '';
      };
    };
  };

  services.udev.extraRules = lib.mkAfter ''
    # for uinput -> kanata
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
}
