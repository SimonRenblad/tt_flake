{
  description = "flake for getting the 'tt' program";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let 
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      tt = pkgs.buildGoModule {
        name = "tt";
        src = pkgs.fetchFromGitHub {
          owner = "lemnos";
          repo = "tt";
          rev = "70bc8a3ba25b69a43b02698d0431136337fd209f";
          sha256 = "sha256-oe0gegMINVmbw1UPvSy9G67D4amQTumlrgvb8H+Y4IM=";
        };
        vendorHash = "sha256-iny0OKInHqoXzYcEtd4f0T/yty5/z3k3yFbDo5yazes=";
        buildPhase = ''
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          install -m755 bin/tt $out/bin
        '';
      };
    in {
      packages.x86_64-linux.default = tt;
    };
}
