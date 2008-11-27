//
//  OptionParser.mm
//  Created by Allan Odgaard on 2007-09-24.
//

#import <map>
#import <string>
#import "OptionParser.h"
#import "Dialog2.h"

using namespace std;

struct tokenizer_t
{
	NSArray* array;
	unsigned index;

	enum { between_words, in_short, in_long } state;
	bool did_unget, disabled;
	string partial_word;

	struct token_t
	{
		enum type_t { option, value, literal, end } type;
		string word;

		token_t (type_t type = end, NSString* word) : type(type), word([word UTF8String]) { }
		token_t (type_t type = end, string word = "") : type(type), word(word) { }
	};

	token_t current_token;

	tokenizer_t (NSArray* array) : array(array), index(0), state(between_words), did_unget(false), disabled(false) { }

	token_t get (bool expects_argument = false)
	{
		if(did_unget)
		{
			did_unget = false;
		}
		else if(index == [array count])
		{
			current_token = token_t();
		}
		else if(disabled)
		{
			current_token = token_t(token_t::literal, [array objectAtIndex:index++]);
		}
		else if(state == in_long || (expects_argument && state == in_short))
		{
			++index;
			state = between_words;
			current_token = token_t(token_t::value, partial_word);
		}
		else if(state == in_short)
		{
			current_token = token_t(token_t::option, partial_word.substr(0, 1));

			partial_word.erase(0, 1);
			if(partial_word.empty())
			{
				++index;
				state = between_words;
			}
		}
		else
		{
			string word([[array objectAtIndex:index] UTF8String]);
			if(word == "--")
			{
				disabled = true;
				++index;
				get();
			}
			else if(word.size() > 2 && word.substr(0, 2) == "--")
			{
				string::iterator eq_pos = find(word.begin(), word.end(), '=');
				current_token = token_t(token_t::option, string(word.begin() + 2, eq_pos));

				if(eq_pos != word.end())
				{
					partial_word = string(eq_pos + 1, word.end());
					state = in_long;
				}
				else
				{
					++index;
				}
			}
			else if(word.size() > 1 && word.substr(0, 1) == "-")
			{
				current_token = token_t(token_t::option, word.substr(1, 1));

				if(word.size() == 2)
				{
					++index;
				}
				else
				{
					partial_word = word.substr(2, string::npos);
					state = in_short;
				}
			}
			else
			{
				current_token = token_t(expects_argument ? token_t::value : token_t::literal, [array objectAtIndex:index++]);
			}
		}
		return current_token;
	}
	
	void unget ()
	{
		assert(did_unget == false);
		did_unget = true;
	}
};

id create_type (std::string const& str, option_t::type_t const& type, NSString** err_out = NULL)
{
	id res = nil;
	switch(type)
	{
		case option_t::string:
		{
			res = [NSString stringWithUTF8String:str.c_str()];
		}
		break;

		case option_t::integer:
		{
			res = [NSNumber numberWithLong:atol(str.c_str())];
		}
		break;

		case option_t::plist:
		{
			NSString* error = nil;

			if (str.size() > 0) {
				res = [NSPropertyListSerialization propertyListFromData:[NSData dataWithBytes:str.data() length:str.size()] mutabilityOption:NSPropertyListMutableContainersAndLeaves format:nil errorDescription:&error];
				if(error || !res)
					*err_out = [NSString stringWithFormat:@"%@\n%s\n", (error ?: @"unknown error parsing property list"), str.c_str()];
			} else
				res = [NSMutableDictionary dictionary];
		}
		break;
	}
	return res;
}

NSDictionary* ParseOptions (NSArray* arguments, option_t const* available, size_t n)
{
	typedef tokenizer_t::token_t token_t;

	map<string, option_t const*> m;
	for(size_t i = 0; i < n; ++i)
	{
		m[available[i].long_option] = &available[i];
		if(available[i].short_option != "")
			m[available[i].short_option] = &available[i];
	}

	NSMutableDictionary* options = [NSMutableDictionary dictionary];
	NSMutableArray* literals = [NSMutableArray array];

	tokenizer_t tokenizer(arguments);
	bool done = false;
	char* error = NULL;
	do {

		token_t const& t = tokenizer.get();
		switch(t.type)
		{
			case token_t::option:
			{
				map<string, option_t const*>::iterator it = m.find(t.word);
				if(it == m.end())
				{
					asprintf(&error, "no such option: %s", t.word.c_str());
				}
				else
				{
					NSString* key = [NSString stringWithUTF8String:it->second->long_option.c_str()];

					token_t const& val = tokenizer.get(it->second->argument != option_t::no_argument);
					if(val.type == token_t::value)
					{
						if(it->second->argument != option_t::no_argument)
						{
							NSString* err = nil;
							if(id value = create_type(val.word, it->second->type, &err))
									[options setObject:value forKey:key];
							else	error = strdup([err UTF8String]);
						}
						else	asprintf(&error, "no argument allowed after %s, found %s", t.word.c_str(), val.word.c_str());
					}
					else if(it->second->argument == option_t::required_argument)
					{
						asprintf(&error, "required argument for option %s is missing", t.word.c_str());
					}
					else
					{
						[options setObject:[NSNumber numberWithBool:YES] forKey:key];
						tokenizer.unget();
					}
				}
			}
			break;

			case token_t::literal:
			{
				[literals addObject:[NSString stringWithUTF8String:t.word.c_str()]];
			}
			break;

			case token_t::end:
			{
				done = true;
			}
			break;
		}

	} while(!error && !done);

	NSString* errString = error ? [NSString stringWithUTF8String:error] : nil;
	free(error);

	return [NSDictionary dictionaryWithObjectsAndKeys:
		options,		@"options",
		literals,	@"literals",
		errString,	@"error",
		nil];
}

NSString *GetOptionList (option_t const *options, size_t optionCount)
{
	size_t longestOption = 0;
	for(size_t i = 0; i < optionCount; ++i)
		longestOption = std::max(options[i].long_option.size(), longestOption);

	std::string res;
	for(size_t i = 0; i < optionCount; ++i)
	{
		bool hasShort = options[i].short_option.size();
		bool hasLong  = options[i].long_option.size();

		res += " ";
		res += (hasShort            ? "-" + options[i].short_option  : "  ");
		res += (hasShort && hasLong ? ", "                           : "  ");
		res += (hasLong             ? "--" + options[i].long_option  : "  ");
		res += std::string(longestOption - options[i].long_option.size(), ' ');
		res += "     ";
		res += options[i].description;
		res += "\n";
	}

	return [NSString stringWithUTF8String:res.c_str()];
}
