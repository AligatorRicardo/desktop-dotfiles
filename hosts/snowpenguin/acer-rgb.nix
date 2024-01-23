{ stdenv, lib, fetchFromGitHub, kernel, kmod }:
stdenv.mkDerivation rec {
  name = " acer-predator-turbo-and-rgb-keyboard-linux-module-${version}-${kernel.modDirVersion}";
  version = "main";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = "${version}";
    sha256 = "za8dbO5ZBaqdwohTgstyC3jbqOxLIq8bJuy0ASHWYew=";
  };

   setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';
  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = kernel.makeFlags ++ [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];
  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ]; 


  meta = with lib; {
    description = "Improved Linux driver for Acer RGB Keyboards ";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
