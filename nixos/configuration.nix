# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
    
  #Bluetooth

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  services.blueman.enable = true;  
  services.pulseaudio.enable = false;
  security.rtkit.enable=true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true; 
    jack.enable = true;   

    wireplumber.enable = true; 

    
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Boh chat mi ha detto di scriverlo
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  services.getty.autologinUser = "gabriele";
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gabriele = {
    isNormalUser = true;
    description = "gabriele";
    extraGroups = [ "networkmanager" "wheel" "audio" "bluetooth" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim   
     wget
     kitty
     waybar
     git
     hyprpaper
     firefox
     vscodium
     pavucontrol
     rofi
     nwg-look
     clipman
     yazi
     pulseaudio
     vesktop
     obsidian
  ];
  nix.settings.experimental-features =  [ "nix-command" "flakes"];
  
  system.stateVersion = "25.11"; # Did you read the comment?
  programs.steam = {
    enable = true;

  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];


}
