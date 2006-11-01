# TerminalMate — The TextMate Terminal

TerminalMate is a terminal for TextMate. It is inspired by emacs's inferior-modes.

## Installation

1. Install TerminalMate.tmbundle
2. Install TerminalMate.tmplugin

## Usage

1. Switch to a source mode currently supported (Ruby, Python, OCaml, Ruby on Rails, Shell, or Haskell)
2. All key combinations are based off of ⌃⇧I.

## TODOs

1. Better handling of iTerm preferences
2. Paste Selection (Silently)
3. Use sessions (tabs) instead of new windows

## Known Issues

1. The iTerm Preferences window is in the “Window” menu, and not in the TextMate menu.

## Download

* [TerminalMate 0.1.2](TerminalMate-0.1.2.zip)

## News

### 0.2
* Sending input after you close a terminal will now not crash TextMate.

### 0.1.2
* TerminalMate will now change directories to `TM_PROJECT_DIRECTORY` if it is set
* Added support for Rails and Shell modes

### 0.1.1
* Growl is now dynamically loaded.

### 0.1
* Initial release
