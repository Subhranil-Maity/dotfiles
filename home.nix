{ config, pkgs, userConfig, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userConfig.username;
  home.homeDirectory = "/home/" + userConfig.username;

	# imports = [
	# 	("./wm/" + userConfig.wm + ".nix")	
	# ];
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
