{ config, lib, inputs, ... }:

{
  imports = [
    inputs.lix-module.nixosModules.default
  ];
}

# # In your NixOS configuration (e.g., hosts/your-host/default.nix)

# { config, lib, pkgs, ... }:

# {
#   imports = [
#     # Your existing imports...
#     ../../lix-config.nix  # Import the Lix configuration
#   ];

#   # Rest of your host-specific configuration...
# }
