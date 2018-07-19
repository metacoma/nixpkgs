{ stdenv, lib, fetchurl, jre, libXtst, unzip }:

stdenv.mkDerivation rec {
  name = "freeplane-${version}";
  version = "1.6.15";

	src = fetchurl {
		url = "https://datapacket.dl.sourceforge.net/project/freeplane/freeplane%20stable/freeplane_bin-${version}.zip";
		sha256 = "92681853bd60745426ebbc8c77c6292aa3962fa46c61bc73f66b0e0551fdce73";
		curlOpts = ["-L"];
	};


  nativeBuildInputs = [ unzip ];

  unpackCmd = "mkdir root ; unzip $curSrc -d root";

  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  libPath = lib.makeLibraryPath [ libXtst ];

  installPhase = ''
    mkdir -p $out/{freeplane,libexec}
		cp -vr $name/* $out/freeplane
    ln -s ${jre} $out/libexec/jre
  '';

  meta = with stdenv.lib; {
    description = "Mind-mapping software";
    longDescription = ''
			Freeplane is a free and open source software application that supports thinking,
			sharing information and getting things done at work, in school and at home. The 
			software can be used for mind mapping and analyzing the information contained in 
			mind maps. 
    '';
    homepage = https://www.freeplane.org/;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ metacoma ];
  };
}
