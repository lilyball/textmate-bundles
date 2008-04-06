# TM INTERACTIVE INPUT

A library to allow scripts/processes running under TextMate to request input from the user.

## How it works

`tm_interactive_input.dylib` implements a version of the system `read()` call which, under certain conditions, presents a dialog to the user (via `tm_dialog`) allowing them to give the script or process input. Using a feature of `dyld` we can insert this library into any process at launch time.

## Usage

To utilise this library, you must set the following environment variables:

* DYLD\_INSERT_LIBRARIES

From `man dyld`…

	This is a colon separated list of dynamic libraries to load before the ones specified in the program.

You must specify the path to the `tm_interactive_input.dylib` as one of the entries in this env var.

* DYLD\_FORCE\_FLAT_NAMESPACE

Again from `man dyld` regarding `DYLD_INSERT_LIBRARIES`…

	Note  that  this  has  no  effect on images built a two-level namespace images using a dynamic shared library unless DYLD_FORCE_FLAT_NAMESPACE is also used.

You can set this to any value.

* DIALOG

The path to `tm_dialog` (this is automatically set by TM anyway).

* TM\_INTERACTIVE_INPUT

Specifies the *mode* to operate under. See the next section.

## Mode

The `TM_INTERACTIVE_INPUT` env var controls the operation of the library. The following are the different modes:

* NEVER

Don't use the requester i.e. don't do anything.

* AUTO

Request input from the user if there is no data already waiting at `STDIN`.

* ALWAYS

Request input from the user everytime a read is requested, essentially ignoring any data sent to `STDIN`.

**Note:** If `TM_INTERACTIVE_INPUT` is not set, `NEVER` is assumed. If it *is* set but not one of these values, then `AUTO` is assumed.

### Echo mode

You can also toggle 'echo mode' which simulates command line behaviour by echoing the user's input back to stdout when it is entered. You specify 'echo mode' by *or*ing `ECHO` to the input mode…

	TM_INTERACTIVE_INPUT='AUTO|ECHO'

## Passwords

`tm_interactive_input` tries to handle the case when some kind of *secure* input is requested (such as a password). If the last line of output before a read request contains the word '`password`' then a dialog is used that obscures the user input, and if in echo mode `*`'s are echoed to the output instead of the input.
