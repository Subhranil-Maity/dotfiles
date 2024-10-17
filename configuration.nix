# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, systemConfig, userConfig, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
			# ./wm/hyprland.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = systemConfig.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = systemConfig.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemConfig.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemConfig.locale;
    LC_IDENTIFICATION = systemConfig.locale;
    LC_MEASUREMENT = systemConfig.locale;
    LC_MONETARY = systemConfig.locale;
    LC_NAME = systemConfig.locale;
    LC_NUMERIC = systemConfig.locale;
    LC_PAPER = systemConfig.locale;
    LC_TELEPHONE = systemConfig.locale;
    LC_TIME = systemConfig.locale;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland = {
# Install the packages from nixpkgs
	  enable = true;
# Whether to enable XWayland
	  xwayland.enable = true;
  };
# Configure keymap in X11
  services.xserver.xkb = {
	  layout = "us";
	  variant = "";
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${userConfig.username}" = {
    isNormalUser = true;
    description = userConfig.name;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #programs.hyprland.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
	neovim
	tmux
	stow
	git
	python3
	kitty
	btop
	google-chrome
	vscode
	libgcc
	gcc11
	waybar
	wl-clipboard
  ];
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
