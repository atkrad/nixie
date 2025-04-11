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
    goPath = "go"; # Primary GOPATH relative to HOME.
    goPrivate = [
      "gitlab.ci.fdmg.org"
    ];
  };
}
