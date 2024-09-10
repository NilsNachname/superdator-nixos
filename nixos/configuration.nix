{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # ./desktop.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./networking.nix
    ./nix-settings-autoupdate.nix
    ./nvidia.nix
    ./programs.nix
    ./reverse-proxy.nix
    ./security.nix
    ./services.nix
    ./users.nix
  ];

  # Set the hostname for rebuilding
  networking.hostName = "superdator";

  # Use UTC as time zone
  time.timeZone = "Etc/UTC";

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = lib.mkDefault false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use systemd initrd
  boot.initrd.systemd.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # secrets
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets.flinks_password.neededForUsers = true;

  system.stateVersion = "23.11";
}
