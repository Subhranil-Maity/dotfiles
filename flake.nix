{
	description = "My Nix Configiration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ...}:
	let 
		lib = nixpkgs.lib;
		 systemConfig = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        timezone = "Asia/Kolkata"; # select timezone
        locale = "en_IN"; # select locale
      };

		      # ----- USER SETTINGS ----- #
      userConfig = rec {
        username = "immortal"; # username
        name = "Subhranil Maity"; # name/identifier
        email = "fightingdj1@gmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/dotfiles"; # absolute path of the local repo
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
        browser = "google-chrome-stable"; # Default browser; must select one from ./user/app/browser/
        term = "kitty"; # Default terminal command;
        font = "JetBrainsMono"; # Selected font
        editor = "nvim"; # Default editor;
		};
		pkgs = nixpkgs.legacyPackages.${systemConfig.system};


	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				system = systemConfig.system;
				modules = [ ./configuration.nix ];
        specialArgs = {
					inherit userConfig;
					inherit systemConfig;
				};
			};
		};

		homeConfigurations = {
			immortal = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
        extraSpecialArgs = {
					inherit userConfig;
				};
			};
		};
	};

}
