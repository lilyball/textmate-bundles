# `tm_dialog_read`

Luke Daley "ld at ldaley dot com"

A replacement for `read()` that invokes `tm_dialog` to get the **stdin** data if there is none waiting. 

The goal of this is to facilitate scripts/commands running via TextMate that require user input to use `tm_dialog` to get the input, where typically the user would enter it on the command line.

## How It Works

The OS X dynamic linker is capable of loading libraries that replace functions defined in libraries that an executable is actually linked against. We take advantage of this by inserting a replacement for the system `read()` function that is responsible for reading data from file descriptors.

Our implementation of `read()` invokes `tm_dialog` to prompt the user for input if stdin does not have any data at the time of the `read()` call. 

## Usage

To utilise `tm_dialog_read`, several environment variables must be set **before** the process that is to use it launches. 

### Bash 

A bash function is provided to launch a process that you want to use `tm_dialog_read` …

    tm_dialog_read_exec <command> [<title>]

The `command` argument is a string that is to be executed using `eval` that should launch your process. The optional `title` argument is the title of the dialog window that will be presented to the user when `command` requests input.

### Ruby

A ruby method is also provided …

    TextMate::DialogRead.use(title) do 
      # Open Process Here
    end

Any processes opened within the block will use `tm_dialog_read`. The `title` argument is optional.

### About Output Buffering

To get the maximum benefit from this, you should consider the output buffering of the process that is utilising tm\_dialog_read. A common idiom is for scripts/processes to do something like the following:

    Please enter something: *

Where the `*` is the cursor position (when running on the command line).

If you are running a process and writing it's output to TM's html output window then you might find that the tm\_dialog_read requester appears to the user, but they have no idea of what is being requested of them. This can be caused by a number of things ...

* Script/process being run is not flushing output before requesting input

Unfortunately, there is not much you can do about this. Unless you are able to modify the source of course.

* You are reading the output of the script being run a line at a time

The solution to this is obviously not to read a line at a time. Note that `TextMate::IO.exhaust()` read returns complete lines by default. You can turn this off by setting `TextMate::IO.sync` to `true`.

* If rendering to HTML, your are outputting incomplete tags

WebKit uses it's own output buffering. A way to get around this is to wrap each write in a tag (A `<span>` tag for example). This seems to force WebKit to write it out.

### Bugs

There is only one known bug, but it's more of a limitation than a bug. The returned input is limited to the size of the buffer passed to read (which seems to be usually `4096`). This shouldn't be too much of a problem as the buffer is rather large and you wouldn't expect the user to input such a quantity of data. If the user did input more data into the dialog than the buffer can handle, it will be silently truncated.