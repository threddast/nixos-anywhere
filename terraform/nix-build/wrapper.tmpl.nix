let
  cfg = (builtins.getFlake "file://$flake_dir/flake.nix?narHash=$flake_nar").$config_path;
in cfg.extendModules {
  # pass the content thru fetchTree (over directly passing content) to prevent stack overflows
  specialArgs = builtins.fromJSON (builtins.readFile (builtins.fetchTree {
    type = "file";
    url = (if (builtins.compareVersions builtins.nixVersion "2.19") == -1 then "" else "file:") + "$content_file";
    narHash = "$content_nar";
  }).outPath);
}
