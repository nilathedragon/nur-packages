{
  lib,
  buildPythonApplication,
  fetchFromGitHub,
  callPackage,

  click,
  frida-tools,
  wallbreaker ? (callPackage ../python-packages/wallbreaker { }),
}:

buildPythonApplication rec {
  pname = "frida-dexdump";
  version = "v2.0.1";
  format = "setuptools";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "hluwa";
    repo = "frida-dexdump";
    rev = version;
    sha256 = "sha256-k9DIC384sGv2pPeLxHkwBh7K3ukJKJ1jGhnNQt2oAdk=";
  };

  propagatedBuildInputs = [
    click
    frida-tools
    wallbreaker
  ];

  meta = {
    description = "A tool to dump the dex files from a running process";
    longDescription = ''
      frida-dexdump is a tool to dump the dex files from a running process, powered by frida.
    '';
    license = lib.licenses.gpl3Only;
    homepage = "https://github.com/hluwa/frida-dexdump";
    changelog = "https://github.com/hluwa/frida-dexdump/releases/tag/${version}";
  };
}