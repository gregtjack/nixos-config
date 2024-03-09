{ pkgs, hostname, ... }:
{
  networking.hostName = hostname;

  # Enable networking
  networking.networkmanager.enable = true;

  # proton vpn
  networking.wg-quick.interfaces = {
    wg-pvpn-us = {
      autostart = false;
      address = ["10.2.0.2/32"];
      listenPort = 51820;
      privateKeyFile = "/etc/keys/protonvpn.key";
      peers = [
        {
          publicKey = "mqoQwexGzvYJ63u35PJukMOleZXRLLkfQKODwm3NPB4=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "37.19.221.197:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}