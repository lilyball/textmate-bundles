//
//  OptionParser.h
//  Created by Allan Odgaard on 2007-09-24.
//

#import <Cocoa/Cocoa.h>
#import <string>

struct option_t
{
	std::string short_option, long_option;
	enum { no_argument, optional_argument, required_argument } argument;
	enum type_t { string, integer, plist } type;
};

NSDictionary* ParseOptions (NSArray* arguments, option_t const* available, size_t n);

template <size_t N> NSDictionary* ParseOptions (NSArray* arguments, option_t const (&available)[N])
{
	return ParseOptions(arguments, available, N);
}
