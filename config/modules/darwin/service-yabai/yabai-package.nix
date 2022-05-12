{ lib, stdenv, fetchFromGitHub, Carbon, Cocoa, ScriptingBridge, xxd, ... }:

stdenv.mkDerivation rec {
  pname = "yabai";
  version = "4.0.0";

  src = fetchFromGitHub {
    owner = "koekeishiya";
    repo = "yabai";
    rev = "v${version}";
    sha256 = "rllgvj9JxyYar/DTtMn5QNeBTdGkfwqDr7WT3MvHBGI=";
  };

  buildInputs = [ Carbon Cocoa ScriptingBridge xxd ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/man/man1/
    cp ./bin/yabai $out/bin/yabai
    cp ./doc/yabai.1 $out/share/man/man1/yabai.1
  '';

  meta = with lib; {
    description = ''
      A tiling window manager for macOS based on binary space partitioning.
    '';
    homepage = "https://github.com/koekeishiya/yabai";
    platforms = platforms.darwin;
    maintainers = with maintainers; [ cmacrae ];
    license = licenses.mit;
  };
}
