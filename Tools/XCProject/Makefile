

# pushd "$HOME/Library/Application Support/TextMate/Tools/XCProject"; make install; popd

xcode_to_tmproj: ConvertXcodeToTMProj.m XCProject.m XCProject.h XCodeArchiveTypes.h Makefile
	cc -arch i386 -arch ppc -ObjC -lobjc -Os -framework Foundation -std=c99 ConvertXcodeToTMProj.m XCProject.m -o xcode_to_tmproj

install: xcode_to_tmproj
	cp xcode_to_tmproj ../../Bundles/Xcode.tmbundle/Support/bin/
