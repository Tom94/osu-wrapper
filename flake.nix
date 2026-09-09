{
  description = "osu!lazer devenv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        ldLibraryPath = pkgs.lib.makeLibraryPath (
          with pkgs;
          [
            wayland
            libxkbcommon
          ]
        );
      in
      {
        devShell =
          let
            libs = with pkgs; [
              ffmpeg
              alsa-lib
              lttng-ust
              numactl
              libglvnd
              udev

              libdecor
              libx11
              libxcb
              libxcursor
              libxext
              libxfixes
              libxi
              libxkbcommon
              libxrandr
              libxrender
              libxscrnsaver
              libxtst
              wayland
              wayland-protocols
              wayland-scanner

              vulkan-loader
            ];
          in
          pkgs.mkShell {
            buildInputs =
              libs
              ++ (with pkgs; [

                vulkan-headers
                vulkan-validation-layers
                vulkan-extension-layer
                vulkan-tools
              ]);

            nativeBuildInputs = with pkgs; [
              cmake
              ninja
              pkg-config
            ];

            shellHook = ''
              export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.lib.makeLibraryPath libs}:${ldLibraryPath}:''${LD_LIBRARY_PATH:-}"
              export VK_LAYER_PATH="${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d:${pkgs.vulkan-extension-layer}/share/vulkan/explicit_layer.d"
            '';
          };
      }
    );
}
