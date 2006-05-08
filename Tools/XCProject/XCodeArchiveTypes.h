//
// File: XCodeArchiveTypes.h
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
// Reverse-engineered by staring at many pbxproj files.
//
// We don't know the actual class hierarchy of these objects in Xcode's
// implementation, but for archiving purposes, it doesn't matter.
//

@interface PBXObject : NSObject
@end

@interface PBXBuildSettingsParent : PBXObject
{
	id name;
	id buildSettings;
}
@end

@interface XCBuildConfiguration : PBXBuildSettingsParent
@end

@interface PBXBuildStyle : PBXBuildSettingsParent
@end


@interface XCConfigurationList : PBXObject
{
	id buildConfigurations;
	id defaultConfigurationName;
	id defaultConfigurationIsVisible;
}
@end

@interface PBXBuildFile : PBXObject
{
	id	fileRef;
	id	settings;
}
@end
@interface PBXBuildRule : PBXObject
{
	id compilerSpec;
	id fileType;
	id isEditable;
	id outputFiles;
	id script;
}
@end

@interface PBXContainerItemProxy : PBXObject
{
	id containerPortal;
	id proxyType;
	id remoteGlobalIDString;
	id remoteInfo;
}
@end
@interface PBXFileReference : PBXObject
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
@interface PBXVariantGroup : PBXGroup
@end
@interface PBXProject : PBXObject
{
	id buildConfigurationList;
	id buildSettings;
	id buildStyles;
	id hasScannedForEncodings;
	id mainGroup;
	id projectDirPath;
	id targets;
	id productRefGroup;
	id knownRegions;
}
@end
@interface PBXTarget : PBXObject
{
	id productInstallPath;
	id productType;
	id buildRules;
	id buildPhases;
	id buildSettings;
	id buildConfigurationList;
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

@interface PBXBuildPhase : PBXObject
{
	id buildActionMask;
	id files;
	id runOnlyForDeploymentPostprocessing;
}
@end
//@interface PBXShellScriptBuildPhase : PBXBuildPhase
//{
//	id inputPaths;
//	id outputPaths;
//	id shellPath;
//	id shellScript;
//}
//@end
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
@interface PBXTargetDependency : PBXObject
{
	id	target;
	id	targetProxy;
}
@end
