{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
  ];

  home.sessionVariables = {
    GOPROXY = "https://proxy.golang.org,direct";
  };

  programs.go = {
    enable = true;
    package = pkgs.unstable.go;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOPRIVATE = [
        "gitlab.ci.fdmg.org"
      ];
    };
  };
}
