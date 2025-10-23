{
  description = "A Typst project that uses unpublished Typst packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # TODO: Change this and the list in `unpublishedTypstPackages`

    # Example of downloading icons from a non-flake source
    # font-awesome = {
    #   url = "github:FortAwesome/Font-Awesome";
    #   flake = false;
    # };
  };

  outputs =
    inputs@{
      nixpkgs,
      typix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) lib;
        inherit (lib.strings) escapeShellArg;

        typixLib = typix.lib.${system};

        src = typixLib.cleanTypstSource ./.;
        commonArgs = {
          typstSource = "main.typ";

          fontPaths = [
            # Add paths to fonts here
            "${pkgs.roboto}/share/fonts/truetype"
            "${pkgs.font-awesome}/share/fonts/opentype"
            "${pkgs.nerd-fonts.symbols-only}/share/fonts/opentype"
            "${pkgs.nerd-fonts.symbols-only}/share/fonts/truetype"
          ];

          virtualPaths = [
            # Add paths that must be locally accessible to typst here
            # {
            #   dest = "icons";
            #   src = "${inputs.font-awesome}/svgs/regular";
            # }
          ];
        };

        mkTypstPackagesDrv =
          name: entries:
          let
            linkFarmEntries = lib.foldl (
              set:
              {
                name,
                version,
                namespace,
                input,
              }:
              set
              // {
                "${namespace}/${name}/${version}" = input;
              }
            ) { } entries;
          in
          pkgs.linkFarm name linkFarmEntries;

        unpublishedTypstPackages = mkTypstPackagesDrv "unpublished-typst-packages" [
        ];

        # Any transitive dependencies must be added here
        # See https://loqusion.github.io/typix/recipes/using-typst-packages.html#the-typstpackages-attribute
        unstable_typstPackages = [
        ];

        # Compile a Typst project, *without* copying the result
        # to the current directory
        build-drv = typixLib.buildTypstProject (
          commonArgs
          // {
            inherit src;
            inherit unstable_typstPackages;
            TYPST_PACKAGE_PATH = unpublishedTypstPackages;
          }
        );

        # Compile a Typst project, and then copy the result
        # to the current directory
        build-script = typixLib.buildTypstProjectLocal (
          commonArgs
          // {
            inherit src;
            inherit unstable_typstPackages;
            TYPST_PACKAGE_PATH = unpublishedTypstPackages;
          }
        );

        # Watch a project and recompile on changes
        watch-script = typixLib.watchTypstProject (
          commonArgs
          // {
            typstWatchCommand = "TYPST_PACKAGE_PATH=${escapeShellArg unpublishedTypstPackages} typst watch";
          }
        );
      in
      {
        checks = {
          inherit build-drv build-script watch-script;
        };

        packages.default = build-drv;

        apps = rec {
          default = watch;
          build = flake-utils.lib.mkApp {
            drv = build-script;
          };
          watch = flake-utils.lib.mkApp {
            drv = watch-script;
          };
        };

        devShells.default = typixLib.devShell {
          inherit (commonArgs) fontPaths virtualPaths;
          packages = [
            # WARNING: Don't run `typst-build` directly, instead use `nix run .#build`
            # See https://github.com/loqusion/typix/issues/2
            # build-script
            watch-script
            # More packages can be added here, like typstfmt
            # pkgs.typstfmt
            pkgs.tinymist
          ];

          TYPST_PACKAGE_PATH = unpublishedTypstPackages;
        };
      }
    );
}
