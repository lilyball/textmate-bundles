$NIB              = `uname -r`.split('.')[0].to_i > 8 ? 'BundlesTree' : 'BundlesTreeTiger'
$isDIALOG2        = ! ENV['DIALOG'].match(/2$/).nil?
# DIALOG's parameters hash
$params           = { }
# DIALOG's async token
$token            = nil
$infoToken        = nil
# result hash of the the DIALOG
$dialogResult     = { }

# table of all bundles with repo, name, bundleDescription, path
$dataarray        = [ ]

# set to true if Cancel button was pressed to interrput threads and each loops
$close            = false
# set to true for fetching something from the net (used for shut down procedure)
$listsLoaded      = false
# total number of found bundles
$numberOfBundles  = 0
# main run loop variable
$run              = true
# global error counter
$errorcnt         = 0
# temp dir for installation
$tempDir          = "/tmp/TM_GetBundlesTEMP"
# global timeout in seconds
$timeout          = 45
# global thread vars
$initThread       = nil
$installThread    = nil
$infoThread       = nil
$refreshThread    = nil
$reloadThread     = nil
$svnlogThread     = nil
$svndataThread    = nil
$locBundlesThread = nil
$svnInfoHostThread = nil;
# bundle data hash containing data.json.gz 
$bundleCache      = { }
# hash of used nicknames
$nicknames        = { }
# available installation modi
$availableModi    = ["svn", "tar", "zip"]
# URL to the bundle server's cache file
$bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json.gz"
# URL to nicknames.txt
$nickNamesFile = "http://bibiko.textmate.org/bundleserver/nicknames.txt"
# locally installed bundles
$localBundles     = { }
# does have an uuid a local change
$localBundlesChanges = { }
# paths of local changes per uuid
$localBundlesChangesPaths = { }
# how many sources per uuid
$numberOfBundleSources = { }
# all sources per uuid
$bundleSources    = { }

# Pristine's Support Folder
$supportFolderPristine = "#{ENV['HOME']}/Library/Application Support/TextMate/Pristine Copy/Support"

$pristineCopyFolder = "#{ENV['HOME']}/Library/Application Support/TextMate/Pristine Copy"
# TextMate's standard Support folder
$asFolder    = "/Library/Application Support/TextMate"
# TextMate's Support Folder
$supportFolder    = "#{$asFolder}/Support"
# should the Support Folder updated in beforehand?
$updateSupportFolder = true
# last bundle filter selection
$lastBundleFilterSelection = "All"
# hash with uuid of deleted or disabled bundles stored in TextMate's plist
$delCoreDisBundles = { }
# array of just installed bundles which are marked as deleted/disabled for status
$justUndeletedCoreAndEnabledBundles = [ ]
# array of current checkbox values to figure out which checkbox was changed
$deleteBundleOrgStatus = { }
# colors for bundles which have the same uuid (alternating)
$bundleColors = [ '#663300', '#993300' ]

# the Log file
$logFilePath = "#{ENV['HOME']}/Library/Logs/TextMateGetBundles.log"
# GetBundles' plist path
$gbPlistPath = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.getbundles.plist"
