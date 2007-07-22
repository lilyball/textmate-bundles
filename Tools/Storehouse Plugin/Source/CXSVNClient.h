// 
//  CXSVNClient.h
//  
//  Created by Chris Thomas on 2006-11-10.
//  Copyright 2006 Chris Thomas. All rights reserved.
// 

@interface CXSVNClient : NSObject
{
	id fObserver;
	id fUserInfo;
}

// Observer is retained. Call [setObserver:nil] to clear it.
- (id)observer;
- (void)setObserver:(id)aValue;

- (id)userInfo;
- (void)setUserInfo:(id)aValue;


- (void) moveURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc;
- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc;
- (void) makeDirsAtURLs:(NSArray *)addDirURLs withDescription:(NSString *)desc;
- (void) removeURLs:(NSArray *)removeURLs withDescription:(NSString *)desc;
- (void) removeURL:(NSString *)destURL withDescription:(NSString *)desc;
- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc;
- (void) importLocalPath:(NSString *)sourcePath toURL:(NSString *)destURL withDescription:(NSString *)desc;

- (void) exportURL:(NSString *)sourceURL toLocalPath:(NSString *)path;
- (void) checkoutURL:(NSString *)sourceURL toLocalPath:(NSString *)path;

- (void) listContentsOfURL:(NSString *)sourceURL toSelector:(SEL)sel ofObject:(id)target;

- (void) contentsOfSVNURLDidChange:(NSString *)url;

@end

@interface NSObject(CXSVNTaskObserver)
- (void) startingTask;
- (void) exitedSVNWithStatus:(int)terminationStatus userInfo:(id)userInfo;
- (void) readSVNOutput:(NSString *)output;
- (void) readSVNError:(NSString *)error;
- (void) contentsOfSVNURLDidChange:(NSString *)url;
@end
