/*
	g++ "$TM_FILEPATH" -o "$TM_SUPPORT_PATH/bin/jsrun" -Os -Wall -arch i386 -arch ppc -framework JavaScriptCore	
*/
	
#include <JavaScriptCore/JavaScriptCore.h>
#include <unistd.h>
#include <vector>

void error (char const* str)
{
	fprintf(stderr, "error: %s\n", str);
	exit(-1);
}

int main (int argc, char const* argv[])
{
	std::vector<char> v;
	char buf[1024];
	while(ssize_t len = read(STDIN_FILENO, buf, sizeof(buf)))
	{
		if(len == -1)
			return -1;
		v.insert(v.end(), buf, buf + len);
	}

	JSGlobalContextRef context = JSGlobalContextCreate(nil);
	if(!context)
		error("creating global script context");

	JSStringRef script = JSStringCreateWithUTF8CString(&v[0]);
	if(!script)
		error("creating string from script");

	JSValueRef res = JSEvaluateScript(context, script, nil, nil, 0, nil);
	if(!res)
		error("evaluating script");

	if(!JSValueIsString(context, res))
		error("non-string result");

	JSStringRef resString = JSValueToStringCopy(context, res, nil);
	size_t len = JSStringGetLength(resString);

	char output[len];
	JSStringGetUTF8CString(resString, output, len);
	write(STDOUT_FILENO, output, len);
	return 0;
}
