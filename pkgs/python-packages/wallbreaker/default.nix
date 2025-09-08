{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  build,
  click,
  frida-python,
  installer,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "wallbreaker";
  version = "1.0.3";
  format = "setuptools";
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "hluwa";
    repo = "Wallbreaker";
    rev = "${version}";
    sha256 = "sha256-bnW/4hTlaQqGidNIa39dqiziLgcO/ZZW6c3EVG57Cjg=";
  };

  propagatedBuildInputs = [
    click
    frida-python
  ];

  meta = {
    description = "Break Java Reverse Engineering from Memory World";
    longDescription = ''
      Wallbreaker is a useful tool to live analyzing Java heap, powered by frida.
      Provide some commands to search object or class from the memory, and beautifully visualize the real structure of the target.
      Want to know real data content? list item? map entries? Want to know about implementation of the interface? Try it! What you see is what you get!
    '';
    license = lib.licenses.gpl3Only;
    homepage = "https://github.com/hluwa/Wallbreaker";
    changelog = "https://github.com/hluwa/Wallbreaker/releases/tag/${version}";
  };
}