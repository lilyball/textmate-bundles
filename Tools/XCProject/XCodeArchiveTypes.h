//
// File: XCodeArchiveTypes.h
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
// Reverse-engineered by staring at a pbxproj file.

@interface PBXBuildFile : NSObject
{
	id	fileRef;
	id	settings;
}
@end
@interface PBXBuildRule : NSObject
{
	id compilerSpec;
	id fileType;
	id isEditable;
	id outputFiles;
	id script;
}
@end
@interface PBXBuildStyle : NSObject
{
	id name;
	id buildSettings;
}
@end
@interface PBXContainerItemProxy : NSObject
{
	id containerPortal;
	id proxyType;
	id remoteGlobalIDString;
	id remoteInfo;
}
@end
@interface PBXFileReference : NSObject
{
	id name;
	id fileEncoding;
	id lastKnownFileType;
	id path;
	id refType;
	id sourceTree;
	id explicitFileType;
	id languageSpecificationIdentifier;
	id includeInIndex;
	
	// not part of the archived ivars
	id XCParentGroup;
}
@end
@interface PBXGroup : PBXFileReference
{
	id children;
}
@end
@interface PBXProject : NSObject
{
	id buildSettings;
	id buildStyles;
	id hasScannedForEncodings;
	id mainGroup;
	id projectDirPath;
	id targets;
	id productRefGroup;
}
@end
@interface PBXTarget : NSObject
{
	id productInstallPath;
	id productType;
	id buildRules;
	id buildPhases;
	id buildSettings;
	id dependencies;
	id name;
	id productName;
	id productReference;
	id productSettingsXML;
}
@end
@interface PBXNativeTarget : PBXTarget
@end
@interface PBXAggregateTarget : PBXTarget
@end

@interface PBXBuildPhase : NSObject
{
	id buildActionMask;
	id files;
	id runOnlyForDeploymentPostprocessing;
}
@end
@interface PBXShellScriptBuildPhase : PBXBuildPhase
{
	id inputPaths;
	id outputPaths;
	id shellPath;
	id shellScript;
}
@end
@interface PBXSourcesBuildPhase : PBXBuildPhase
@end
@interface PBXHeadersBuildPhase : PBXBuildPhase
@end
@interface PBXFrameworksBuildPhase : PBXBuildPhase
@end
@interface PBXResourcesBuildPhase : PBXBuildPhase
@end
@interface PBXRezBuildPhase : PBXBuildPhase
@end
@interface PBXTargetDependency : NSObject
{
	id	target;
	id	targetProxy;
}
@end
