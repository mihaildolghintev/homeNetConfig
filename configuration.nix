# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
 time.timeZone = "Europe/Chisinau";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config = {
		allowUnfree = true;
	};
  environment.variables = {
	MESA_LOADER_DRIVER_OVERRIDE = "iris";
};
  environment.systemPackages = with pkgs; [
    wget
	 vim
   atom
	git
	rofi
	kitty
	polybar
	picom
	feh
	dunst
	google-chrome-beta	
	i3status-rust
	neovim
	unstable.yarn
	unstable.nodejs-14_x
	unstable.elixir
	unstable.obinskit
	unstable.anydesk
  unstable.tdesktop
  unstable.evince
	vscode
  emacs
  unzip
  gnumake
  clang
  gcc
  eterm
  haskellPackages.xmobar
   ];

  fonts = {
	enableFontDir = true;
	fonts = with pkgs; [
		terminus_font
		font-awesome
		ubuntu_font_family
		unstable.jetbrains-mono
	];
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.package = (pkgs.mesa.override {
	galliumDrivers = ["nouveau" "virgl" "swrast" "iris"];
}).drivers;

  # Enable the X11 windowing system.
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.user = "mishakos";
  services.xserver.displayManager.defaultSession = "xfce+xmonad";

services.xserver = {
    enable = true;   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager = {
      xmonad = {
	    enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages : [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
	};
    };
  };
  # services.xserver.desktopManager.plasma5.enable = true;
  #

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mishakos = {
  	isNormalUser = true;
  	extraGroups = [ "wheel" ];
	createHome = true;
	home = "/home/mishakos";
	shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    autosuggestions.extraConfig = {
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"="fg=5";
    };
    enableCompletion = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "sudo" ];
    ohMyZsh.theme = "af-magic";
  };
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}


