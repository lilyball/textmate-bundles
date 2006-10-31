// -*- mode:objc -*-
// $Id: PTYTask.h,v 1.9 2006/03/17 19:08:32 ujwal Exp $
/*
 **  PTYTask.h
 **
 **  Copyright (c) 2002, 2003
 **
 **  Author: Fabian, Ujwal S. Setlur
 **	     Initial code by Kiichi Kusama
 **
 **  Project: iTerm
 **
 **  Description: Implements the interface to the pty session.
 **
 **  This program is free software; you can redistribute it and/or modify
 **  it under the terms of the GNU General Public License as published by
 **  the Free Software Foundation; either version 2 of the License, or
 **  (at your option) any later version.
 **
 **  This program is distributed in the hope that it will be useful,
 **  but WITHOUT ANY WARRANTY; without even the implied warranty of
 **  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 **  GNU General Public License for more details.
 **
 **  You should have received a copy of the GNU General Public License
 **  along with this program; if not, write to the Free Software
 **  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
  Delegate
      readTask:
      brokenPipe
*/

#import <Foundation/Foundation.h>

@interface PTYTask : NSObject
{
    pid_t PID;
    int FILDES;
    int STATUS;
    id DELEGATEOBJECT;
    NSString *TTY;
    NSString *PATH;

    NSString *LOG_PATH;
    NSFileHandle *LOG_HANDLE;
    BOOL hasOutput;
    BOOL firstOutput;

    MPSemaphoreID threadEndSemaphore;
}

- (id)init;
- (void)dealloc;

- (void)launchWithPath:(NSString *)progpath
	     arguments:(NSArray *)args
	   environment:(NSDictionary *)env
		 width:(int)width
		height:(int)height;

- (void)setDelegate:(id)object;
- (id)delegate;

- (void) doIdleTasks;
- (void)readTask:(char *)buf length:(int)length;
- (void)writeTask:(NSData *)data;
- (void)brokenPipe;
- (void)sendSignal:(int)signo;
- (void)setWidth:(int)width height:(int)height;
- (pid_t)pid;
- (int)wait;
- (BOOL)exist;
- (void)stop;
- (int)status;
- (NSString *)tty;
- (NSString *)path;
- (BOOL)loggingStartWithPath:(NSString *)path;
- (void)loggingStop;
- (BOOL)logging;
- (BOOL) hasOutput;
- (void) setHasOutput: (BOOL) flag;
- (BOOL) firstOutput;
- (void) setFirstOutput: (BOOL) flag;

- (NSString *)description;

@end
