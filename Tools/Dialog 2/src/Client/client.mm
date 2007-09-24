/*
	g++ -o /tmp/test "$TM_FILEPATH" -framework Foundation
*/

//
//  client.mm
//  Created by Allan Odgaard on 2007-09-22.
//

#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/select.h>
#include <stdarg.h>
#include <sys/stat.h>
#include <map>
#include <vector>
#include <string.h>
#include <poll.h>
#include <stdlib.h>

#import <Foundation/Foundation.h>
#import "../Dialog.h"

id connect ()
{
	id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"com.macromates.dialog" host:nil];
	[proxy setProtocolForProxy:@protocol(DialogServerProtocol)];
	return proxy;
}

char const* create_pipe (char const* name)
{
	char* filename;
	asprintf(&filename, "/tmp/dialog_fifo_%d_%s", getpid(), name);
	int res = mkfifo(filename, 0666);
	if((res == -1) && (errno != EEXIST))
	{
		perror("Error creating the named pipe");
		exit(1);
   }
	return filename;
}

int open_pipe (char const* name, int oflag)
{
	int fd = open(name, oflag);
	if(fd == -1)
	{
		perror("Error opening the named pipe");
		exit(1);
	}
	return fd;
}

int main (int argc, char const* argv[])
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	id<DialogServerProtocol> proxy = connect();
	if(!proxy)
	{
		fprintf(stderr, "error reaching server\n");
		exit(1);
	}

	char const* stdin_name  = create_pipe("stdin");
	char const* stdout_name = create_pipe("stdout");
	char const* stderr_name = create_pipe("stderr");

	NSMutableArray* args = [NSMutableArray array];
	for(size_t i = 0; i < argc; ++i)
		[args addObject:[NSString stringWithUTF8String:argv[i]]];

	NSMutableDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSString stringWithUTF8String:stdin_name],			@"stdin",
		[NSString stringWithUTF8String:stdout_name],			@"stdout",
		[NSString stringWithUTF8String:stderr_name],			@"stderr",
		[NSString stringWithUTF8String:getcwd(NULL, 0)],	@"cwd",
		args,																@"arguments",
		nil
	];

	[proxy hello:dict];

	int stdin_fd  = open_pipe(stdin_name, O_WRONLY);
	int stdout_fd = open_pipe(stdout_name, O_RDONLY);
	int stderr_fd = open_pipe(stderr_name, O_RDONLY);

	std::map<int, int> fd_map;
	fd_map[STDIN_FILENO] = stdin_fd;
	fd_map[stdout_fd]    = STDOUT_FILENO;
	fd_map[stderr_fd]    = STDERR_FILENO;

	while(fd_map.size() > 1 || (fd_map.size() == 1 && fd_map.find(STDIN_FILENO) == fd_map.end()))
	{
		fd_set readfds, writefds, errorfds;
		FD_ZERO(&readfds); FD_ZERO(&writefds); FD_ZERO(&errorfds);

		int num_fds = 0;
		iterate(it, fd_map)
		{
			FD_SET(it->first, &readfds);
			FD_SET(it->first, &errorfds);
			num_fds = std::max(num_fds, it->first + 1);
		}

		int i = select(num_fds, &readfds, &writefds, &errorfds, NULL);
		if(i == -1)
		{
			perror("Error from select");
			continue;
		}

		std::vector<std::map<int, int>::iterator> to_remove;
		iterate(it, fd_map)
		{
			if(FD_ISSET(it->first, &readfds))
			{
				char buf[1024];
				ssize_t len = read(it->first, buf, sizeof(buf));

				if(len == 0)
						to_remove.push_back(it); // we can’t remove as long as we need the iterator for the ++
				else	write(it->second, buf, len);
			}

			if(FD_ISSET(it->first, &errorfds))
			{
				// anyone knows how to query the fd for what is wrong?
				fprintf(stderr, "error condition on %d\n", it->first);
			}
		}

		iterate(it, to_remove)
		{
			if((*it)->second == stdin_fd)
				close((*it)->second);
			fd_map.erase(*it);
		}
	}

	close(stdout_fd);
	close(stderr_fd);
	unlink(stdin_name);
	unlink(stdout_name);
	unlink(stderr_name);

	[pool release];
	return 0;
}