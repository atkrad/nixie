{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.ollama = {
    enable = false;
    loadModels = ["llama3.2:3b" "deepseek-r1:7b"];
  };

  services.open-webui = {
    enable = false;
    environment = {
      WEBUI_AUTH = "False";
    };
  };
}
