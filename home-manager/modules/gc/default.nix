{ pkgs, lib, ... }:
{
  # Home Manager generations are separate profile roots. Expire them before
  # user GC, matching:
  #   home-manager expire-generations "-7 days"
  #   nix-collect-garbage --delete-older-than 7d
  systemd.user.services.collect-garbage = {
    Unit.Description = "Expire Home Manager generations and collect Nix garbage";
    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "collect-garbage" ''
        set -euo pipefail
        ${lib.getExe pkgs.home-manager} expire-generations '-7 days'
        ${lib.getExe' pkgs.nix "nix-collect-garbage"} --delete-older-than 7d
      '';
    };
  };

  systemd.user.timers.collect-garbage = {
    Unit.Description = "Expire Home Manager generations and collect Nix garbage";
    Install.WantedBy = [ "timers.target" ];
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "30m";
    };
  };
}
