<?php
$_LOOKUP = array( 
"natcasesort" => array( 
	"methodname" => "natcasesort", 
	"version" => "PHP4, PHP5", 
	"method" => "bool natcasesort ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array using a case insensitive \"natural order\" algorithm", 
	"docurl" => "function.natcasesort.html" 
),
"natsort" => array( 
	"methodname" => "natsort", 
	"version" => "PHP4, PHP5", 
	"method" => "bool natsort ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array using a \"natural order\" algorithm", 
	"docurl" => "function.natsort.html" 
),
"ncurses_addch" => array( 
	"methodname" => "ncurses_addch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_addch ( int ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Add character at current position and advance cursor", 
	"docurl" => "function.ncurses-addch.html" 
),
"ncurses_addchnstr" => array( 
	"methodname" => "ncurses_addchnstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_addchnstr ( string s, int n )", 
	"snippet" => "( \${1:\$s}, \${2:\$n} )", 
	"desc" => "Add attributed string with specified length at current position", 
	"docurl" => "function.ncurses-addchnstr.html" 
),
"ncurses_addchstr" => array( 
	"methodname" => "ncurses_addchstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_addchstr ( string s )", 
	"snippet" => "( \${1:\$s} )", 
	"desc" => "Add attributed string at current position", 
	"docurl" => "function.ncurses-addchstr.html" 
),
"ncurses_addnstr" => array( 
	"methodname" => "ncurses_addnstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_addnstr ( string s, int n )", 
	"snippet" => "( \${1:\$s}, \${2:\$n} )", 
	"desc" => "Add string with specified length at current position", 
	"docurl" => "function.ncurses-addnstr.html" 
),
"ncurses_addstr" => array( 
	"methodname" => "ncurses_addstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_addstr ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Output text at current position", 
	"docurl" => "function.ncurses-addstr.html" 
),
"ncurses_assume_default_colors" => array( 
	"methodname" => "ncurses_assume_default_colors", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_assume_default_colors ( int fg, int bg )", 
	"snippet" => "( \${1:\$fg}, \${2:\$bg} )", 
	"desc" => "Define default colors for color 0", 
	"docurl" => "function.ncurses-assume-default-colors.html" 
),
"ncurses_attroff" => array( 
	"methodname" => "ncurses_attroff", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_attroff ( int attributes )", 
	"snippet" => "( \${1:\$attributes} )", 
	"desc" => "Turn off the given attributes", 
	"docurl" => "function.ncurses-attroff.html" 
),
"ncurses_attron" => array( 
	"methodname" => "ncurses_attron", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_attron ( int attributes )", 
	"snippet" => "( \${1:\$attributes} )", 
	"desc" => "Turn on the given attributes", 
	"docurl" => "function.ncurses-attron.html" 
),
"ncurses_attrset" => array( 
	"methodname" => "ncurses_attrset", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_attrset ( int attributes )", 
	"snippet" => "( \${1:\$attributes} )", 
	"desc" => "Set given attributes", 
	"docurl" => "function.ncurses-attrset.html" 
),
"ncurses_baudrate" => array( 
	"methodname" => "ncurses_baudrate", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_baudrate ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns baudrate of terminal", 
	"docurl" => "function.ncurses-baudrate.html" 
),
"ncurses_beep" => array( 
	"methodname" => "ncurses_beep", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_beep ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Let the terminal beep", 
	"docurl" => "function.ncurses-beep.html" 
),
"ncurses_bkgd" => array( 
	"methodname" => "ncurses_bkgd", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_bkgd ( int attrchar )", 
	"snippet" => "( \${1:\$attrchar} )", 
	"desc" => "Set background property for terminal screen", 
	"docurl" => "function.ncurses-bkgd.html" 
),
"ncurses_bkgdset" => array( 
	"methodname" => "ncurses_bkgdset", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "void ncurses_bkgdset ( int attrchar )", 
	"snippet" => "( \${1:\$attrchar} )", 
	"desc" => "Control screen background", 
	"docurl" => "function.ncurses-bkgdset.html" 
),
"ncurses_border" => array( 
	"methodname" => "ncurses_border", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_border ( int left, int right, int top, int bottom, int tl_corner, int tr_corner, int bl_corner, int br_corner )", 
	"snippet" => "( \${1:\$left}, \${2:\$right}, \${3:\$top}, \${4:\$bottom}, \${5:\$tl_corner}, \${6:\$tr_corner}, \${7:\$bl_corner}, \${8:\$br_corner} )", 
	"desc" => "Draw a border around the screen using attributed characters", 
	"docurl" => "function.ncurses-border.html" 
),
"ncurses_bottom_panel" => array( 
	"methodname" => "ncurses_bottom_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_bottom_panel ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Moves a visible panel to the bottom of the stack", 
	"docurl" => "function.ncurses-bottom-panel.html" 
),
"ncurses_can_change_color" => array( 
	"methodname" => "ncurses_can_change_color", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_can_change_color ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Check if we can change terminals colors", 
	"docurl" => "function.ncurses-can-change-color.html" 
),
"ncurses_cbreak" => array( 
	"methodname" => "ncurses_cbreak", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_cbreak ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Switch of input buffering", 
	"docurl" => "function.ncurses-cbreak.html" 
),
"ncurses_clear" => array( 
	"methodname" => "ncurses_clear", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_clear ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clear screen", 
	"docurl" => "function.ncurses-clear.html" 
),
"ncurses_clrtobot" => array( 
	"methodname" => "ncurses_clrtobot", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_clrtobot ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clear screen from current position to bottom", 
	"docurl" => "function.ncurses-clrtobot.html" 
),
"ncurses_clrtoeol" => array( 
	"methodname" => "ncurses_clrtoeol", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_clrtoeol ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clear screen from current position to end of line", 
	"docurl" => "function.ncurses-clrtoeol.html" 
),
"ncurses_color_content" => array( 
	"methodname" => "ncurses_color_content", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_color_content ( int color, int &r, int &g, int &b )", 
	"snippet" => "( \${1:\$color}, \${2:\$r}, \${3:\$g}, \${4:\$b} )", 
	"desc" => "Gets the RGB value for color", 
	"docurl" => "function.ncurses-color-content.html" 
),
"ncurses_color_set" => array( 
	"methodname" => "ncurses_color_set", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_color_set ( int pair )", 
	"snippet" => "( \${1:\$pair} )", 
	"desc" => "Set fore- and background color", 
	"docurl" => "function.ncurses-color-set.html" 
),
"ncurses_curs_set" => array( 
	"methodname" => "ncurses_curs_set", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_curs_set ( int visibility )", 
	"snippet" => "( \${1:\$visibility} )", 
	"desc" => "Set cursor state", 
	"docurl" => "function.ncurses-curs-set.html" 
),
"ncurses_def_prog_mode" => array( 
	"methodname" => "ncurses_def_prog_mode", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_def_prog_mode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Saves terminals (program) mode", 
	"docurl" => "function.ncurses-def-prog-mode.html" 
),
"ncurses_def_shell_mode" => array( 
	"methodname" => "ncurses_def_shell_mode", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_def_shell_mode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Saves terminals (shell) mode", 
	"docurl" => "function.ncurses-def-shell-mode.html" 
),
"ncurses_define_key" => array( 
	"methodname" => "ncurses_define_key", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_define_key ( string definition, int keycode )", 
	"snippet" => "( \${1:\$definition}, \${2:\$keycode} )", 
	"desc" => "Define a keycode", 
	"docurl" => "function.ncurses-define-key.html" 
),
"ncurses_del_panel" => array( 
	"methodname" => "ncurses_del_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_del_panel ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Remove panel from the stack and delete it (but not the associated window)", 
	"docurl" => "function.ncurses-del-panel.html" 
),
"ncurses_delay_output" => array( 
	"methodname" => "ncurses_delay_output", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_delay_output ( int milliseconds )", 
	"snippet" => "( \${1:\$milliseconds} )", 
	"desc" => "Delay output on terminal using padding characters", 
	"docurl" => "function.ncurses-delay-output.html" 
),
"ncurses_delch" => array( 
	"methodname" => "ncurses_delch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_delch ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Delete character at current position, move rest of line left", 
	"docurl" => "function.ncurses-delch.html" 
),
"ncurses_deleteln" => array( 
	"methodname" => "ncurses_deleteln", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_deleteln ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Delete line at current position, move rest of screen up", 
	"docurl" => "function.ncurses-deleteln.html" 
),
"ncurses_delwin" => array( 
	"methodname" => "ncurses_delwin", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_delwin ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Delete a ncurses window", 
	"docurl" => "function.ncurses-delwin.html" 
),
"ncurses_doupdate" => array( 
	"methodname" => "ncurses_doupdate", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_doupdate ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Write all prepared refreshes to terminal", 
	"docurl" => "function.ncurses-doupdate.html" 
),
"ncurses_echo" => array( 
	"methodname" => "ncurses_echo", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_echo ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Activate keyboard input echo", 
	"docurl" => "function.ncurses-echo.html" 
),
"ncurses_echochar" => array( 
	"methodname" => "ncurses_echochar", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_echochar ( int character )", 
	"snippet" => "( \${1:\$character} )", 
	"desc" => "Single character output including refresh", 
	"docurl" => "function.ncurses-echochar.html" 
),
"ncurses_end" => array( 
	"methodname" => "ncurses_end", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_end ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Stop using ncurses, clean up the screen", 
	"docurl" => "function.ncurses-end.html" 
),
"ncurses_erase" => array( 
	"methodname" => "ncurses_erase", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_erase ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Erase terminal screen", 
	"docurl" => "function.ncurses-erase.html" 
),
"ncurses_erasechar" => array( 
	"methodname" => "ncurses_erasechar", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string ncurses_erasechar ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns current erase character", 
	"docurl" => "function.ncurses-erasechar.html" 
),
"ncurses_filter" => array( 
	"methodname" => "ncurses_filter", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_filter ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Set LINES for iniscr() and newterm() to 1", 
	"docurl" => "function.ncurses-filter.html" 
),
"ncurses_flash" => array( 
	"methodname" => "ncurses_flash", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_flash ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flash terminal screen (visual bell)", 
	"docurl" => "function.ncurses-flash.html" 
),
"ncurses_flushinp" => array( 
	"methodname" => "ncurses_flushinp", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_flushinp ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush keyboard input buffer", 
	"docurl" => "function.ncurses-flushinp.html" 
),
"ncurses_getch" => array( 
	"methodname" => "ncurses_getch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_getch ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Read a character from keyboard", 
	"docurl" => "function.ncurses-getch.html" 
),
"ncurses_getmaxyx" => array( 
	"methodname" => "ncurses_getmaxyx", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void ncurses_getmaxyx ( resource window, int &y, int &x )", 
	"snippet" => "( \${1:\$window}, \${2:\$y}, \${3:\$x} )", 
	"desc" => "Returns the size of a window", 
	"docurl" => "function.ncurses-getmaxyx.html" 
),
"ncurses_getmouse" => array( 
	"methodname" => "ncurses_getmouse", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ncurses_getmouse ( array &mevent )", 
	"snippet" => "( \${1:\$mevent} )", 
	"desc" => "Reads mouse event", 
	"docurl" => "function.ncurses-getmouse.html" 
),
"ncurses_getyx" => array( 
	"methodname" => "ncurses_getyx", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void ncurses_getyx ( resource window, int &y, int &x )", 
	"snippet" => "( \${1:\$window}, \${2:\$y}, \${3:\$x} )", 
	"desc" => "Returns the current cursor position for a window", 
	"docurl" => "function.ncurses-getyx.html" 
),
"ncurses_halfdelay" => array( 
	"methodname" => "ncurses_halfdelay", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_halfdelay ( int tenth )", 
	"snippet" => "( \${1:\$tenth} )", 
	"desc" => "Put terminal into halfdelay mode", 
	"docurl" => "function.ncurses-halfdelay.html" 
),
"ncurses_has_colors" => array( 
	"methodname" => "ncurses_has_colors", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_has_colors ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Check if terminal has colors", 
	"docurl" => "function.ncurses-has-colors.html" 
),
"ncurses_has_ic" => array( 
	"methodname" => "ncurses_has_ic", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_has_ic ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Check for insert- and delete-capabilities", 
	"docurl" => "function.ncurses-has-ic.html" 
),
"ncurses_has_il" => array( 
	"methodname" => "ncurses_has_il", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_has_il ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Check for line insert- and delete-capabilities", 
	"docurl" => "function.ncurses-has-il.html" 
),
"ncurses_has_key" => array( 
	"methodname" => "ncurses_has_key", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_has_key ( int keycode )", 
	"snippet" => "( \${1:\$keycode} )", 
	"desc" => "Check for presence of a function key on terminal keyboard", 
	"docurl" => "function.ncurses-has-key.html" 
),
"ncurses_hide_panel" => array( 
	"methodname" => "ncurses_hide_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_hide_panel ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Remove panel from the stack, making it invisible", 
	"docurl" => "function.ncurses-hide-panel.html" 
),
"ncurses_hline" => array( 
	"methodname" => "ncurses_hline", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_hline ( int charattr, int n )", 
	"snippet" => "( \${1:\$charattr}, \${2:\$n} )", 
	"desc" => "Draw a horizontal line at current position using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-hline.html" 
),
"ncurses_inch" => array( 
	"methodname" => "ncurses_inch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string ncurses_inch ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get character and attribute at current position", 
	"docurl" => "function.ncurses-inch.html" 
),
"ncurses_init_color" => array( 
	"methodname" => "ncurses_init_color", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_init_color ( int color, int r, int g, int b )", 
	"snippet" => "( \${1:\$color}, \${2:\$r}, \${3:\$g}, \${4:\$b} )", 
	"desc" => "Set new RGB value for color", 
	"docurl" => "function.ncurses-init-color.html" 
),
"ncurses_init_pair" => array( 
	"methodname" => "ncurses_init_pair", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_init_pair ( int pair, int fg, int bg )", 
	"snippet" => "( \${1:\$pair}, \${2:\$fg}, \${3:\$bg} )", 
	"desc" => "Allocate a color pair", 
	"docurl" => "function.ncurses-init-pair.html" 
),
"ncurses_init" => array( 
	"methodname" => "ncurses_init", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_init ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initialize ncurses", 
	"docurl" => "function.ncurses-init.html" 
),
"ncurses_insch" => array( 
	"methodname" => "ncurses_insch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_insch ( int character )", 
	"snippet" => "( \${1:\$character} )", 
	"desc" => "Insert character moving rest of line including character at current position", 
	"docurl" => "function.ncurses-insch.html" 
),
"ncurses_insdelln" => array( 
	"methodname" => "ncurses_insdelln", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_insdelln ( int count )", 
	"snippet" => "( \${1:\$count} )", 
	"desc" => "Insert lines before current line scrolling down (negative numbers delete and scroll up)", 
	"docurl" => "function.ncurses-insdelln.html" 
),
"ncurses_insertln" => array( 
	"methodname" => "ncurses_insertln", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_insertln ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Insert a line, move rest of screen down", 
	"docurl" => "function.ncurses-insertln.html" 
),
"ncurses_insstr" => array( 
	"methodname" => "ncurses_insstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_insstr ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Insert string at current position, moving rest of line right", 
	"docurl" => "function.ncurses-insstr.html" 
),
"ncurses_instr" => array( 
	"methodname" => "ncurses_instr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_instr ( string &buffer )", 
	"snippet" => "( \${1:\$buffer} )", 
	"desc" => "Reads string from terminal screen", 
	"docurl" => "function.ncurses-instr.html" 
),
"ncurses_isendwin" => array( 
	"methodname" => "ncurses_isendwin", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_isendwin ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Ncurses is in endwin mode, normal screen output may be performed", 
	"docurl" => "function.ncurses-isendwin.html" 
),
"ncurses_keyok" => array( 
	"methodname" => "ncurses_keyok", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_keyok ( int keycode, bool enable )", 
	"snippet" => "( \${1:\$keycode}, \${2:\$enable} )", 
	"desc" => "Enable or disable a keycode", 
	"docurl" => "function.ncurses-keyok.html" 
),
"ncurses_keypad" => array( 
	"methodname" => "ncurses_keypad", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_keypad ( resource window, bool bf )", 
	"snippet" => "( \${1:\$window}, \${2:\$bf} )", 
	"desc" => "Turns keypad on or off", 
	"docurl" => "function.ncurses-keypad.html" 
),
"ncurses_killchar" => array( 
	"methodname" => "ncurses_killchar", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_killchar ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns current line kill character", 
	"docurl" => "function.ncurses-killchar.html" 
),
"ncurses_longname" => array( 
	"methodname" => "ncurses_longname", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string ncurses_longname ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns terminals description", 
	"docurl" => "function.ncurses-longname.html" 
),
"ncurses_meta" => array( 
	"methodname" => "ncurses_meta", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_meta ( resource window, bool 8bit )", 
	"snippet" => "( \${1:\$window}, \${2:\$8bit} )", 
	"desc" => "Enables/Disable 8-bit meta key information", 
	"docurl" => "function.ncurses-meta.html" 
),
"ncurses_mouse_trafo" => array( 
	"methodname" => "ncurses_mouse_trafo", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ncurses_mouse_trafo ( int &y, int &x, bool toscreen )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$toscreen} )", 
	"desc" => "Transforms coordinates", 
	"docurl" => "function.ncurses-mouse-trafo.html" 
),
"ncurses_mouseinterval" => array( 
	"methodname" => "ncurses_mouseinterval", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_mouseinterval ( int milliseconds )", 
	"snippet" => "( \${1:\$milliseconds} )", 
	"desc" => "Set timeout for mouse button clicks", 
	"docurl" => "function.ncurses-mouseinterval.html" 
),
"ncurses_mousemask" => array( 
	"methodname" => "ncurses_mousemask", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mousemask ( int newmask, int &oldmask )", 
	"snippet" => "( \${1:\$newmask}, \${2:\$oldmask} )", 
	"desc" => "Sets mouse options", 
	"docurl" => "function.ncurses-mousemask.html" 
),
"ncurses_move_panel" => array( 
	"methodname" => "ncurses_move_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_move_panel ( resource panel, int startx, int starty )", 
	"snippet" => "( \${1:\$panel}, \${2:\$startx}, \${3:\$starty} )", 
	"desc" => "Moves a panel so that its upper-left corner is at [startx, starty]", 
	"docurl" => "function.ncurses-move-panel.html" 
),
"ncurses_move" => array( 
	"methodname" => "ncurses_move", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_move ( int y, int x )", 
	"snippet" => "( \${1:\$y}, \${2:\$x} )", 
	"desc" => "Move output position", 
	"docurl" => "function.ncurses-move.html" 
),
"ncurses_mvaddch" => array( 
	"methodname" => "ncurses_mvaddch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvaddch ( int y, int x, int c )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$c} )", 
	"desc" => "Move current position and add character", 
	"docurl" => "function.ncurses-mvaddch.html" 
),
"ncurses_mvaddchnstr" => array( 
	"methodname" => "ncurses_mvaddchnstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvaddchnstr ( int y, int x, string s, int n )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$s}, \${4:\$n} )", 
	"desc" => "Move position and add attributed string with specified length", 
	"docurl" => "function.ncurses-mvaddchnstr.html" 
),
"ncurses_mvaddchstr" => array( 
	"methodname" => "ncurses_mvaddchstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvaddchstr ( int y, int x, string s )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$s} )", 
	"desc" => "Move position and add attributed string", 
	"docurl" => "function.ncurses-mvaddchstr.html" 
),
"ncurses_mvaddnstr" => array( 
	"methodname" => "ncurses_mvaddnstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvaddnstr ( int y, int x, string s, int n )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$s}, \${4:\$n} )", 
	"desc" => "Move position and add string with specified length", 
	"docurl" => "function.ncurses-mvaddnstr.html" 
),
"ncurses_mvaddstr" => array( 
	"methodname" => "ncurses_mvaddstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvaddstr ( int y, int x, string s )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$s} )", 
	"desc" => "Move position and add string", 
	"docurl" => "function.ncurses-mvaddstr.html" 
),
"ncurses_mvcur" => array( 
	"methodname" => "ncurses_mvcur", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvcur ( int old_y, int old_x, int new_y, int new_x )", 
	"snippet" => "( \${1:\$old_y}, \${2:\$old_x}, \${3:\$new_y}, \${4:\$new_x} )", 
	"desc" => "Move cursor immediately", 
	"docurl" => "function.ncurses-mvcur.html" 
),
"ncurses_mvdelch" => array( 
	"methodname" => "ncurses_mvdelch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvdelch ( int y, int x )", 
	"snippet" => "( \${1:\$y}, \${2:\$x} )", 
	"desc" => "Move position and delete character, shift rest of line left", 
	"docurl" => "function.ncurses-mvdelch.html" 
),
"ncurses_mvgetch" => array( 
	"methodname" => "ncurses_mvgetch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvgetch ( int y, int x )", 
	"snippet" => "( \${1:\$y}, \${2:\$x} )", 
	"desc" => "Move position and get character at new position", 
	"docurl" => "function.ncurses-mvgetch.html" 
),
"ncurses_mvhline" => array( 
	"methodname" => "ncurses_mvhline", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvhline ( int y, int x, int attrchar, int n )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$attrchar}, \${4:\$n} )", 
	"desc" => "Set new position and draw a horizontal line using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-mvhline.html" 
),
"ncurses_mvinch" => array( 
	"methodname" => "ncurses_mvinch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvinch ( int y, int x )", 
	"snippet" => "( \${1:\$y}, \${2:\$x} )", 
	"desc" => "Move position and get attributed character at new position", 
	"docurl" => "function.ncurses-mvinch.html" 
),
"ncurses_mvvline" => array( 
	"methodname" => "ncurses_mvvline", 
	"version" => "undefined", 
	"method" => "int ncurses_mvvline ( int y, int x, int attrchar, int n )", 
	"snippet" => "( \${1:\$y}, \${2:\$x}, \${3:\$attrchar}, \${4:\$n} )", 
	"desc" => "Set new position and draw a vertical line using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-mvvline.html" 
),
"ncurses_mvwaddstr" => array( 
	"methodname" => "ncurses_mvwaddstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_mvwaddstr ( resource window, int y, int x, string text )", 
	"snippet" => "( \${1:\$window}, \${2:\$y}, \${3:\$x}, \${4:\$text} )", 
	"desc" => "Add string at new position in window", 
	"docurl" => "function.ncurses-mvwaddstr.html" 
),
"ncurses_napms" => array( 
	"methodname" => "ncurses_napms", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_napms ( int milliseconds )", 
	"snippet" => "( \${1:\$milliseconds} )", 
	"desc" => "Sleep", 
	"docurl" => "function.ncurses-napms.html" 
),
"ncurses_new_panel" => array( 
	"methodname" => "ncurses_new_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource ncurses_new_panel ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Create a new panel and associate it with window", 
	"docurl" => "function.ncurses-new-panel.html" 
),
"ncurses_newpad" => array( 
	"methodname" => "ncurses_newpad", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource ncurses_newpad ( int rows, int cols )", 
	"snippet" => "( \${1:\$rows}, \${2:\$cols} )", 
	"desc" => "Creates a new pad (window)", 
	"docurl" => "function.ncurses-newpad.html" 
),
"ncurses_newwin" => array( 
	"methodname" => "ncurses_newwin", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource ncurses_newwin ( int rows, int cols, int y, int x )", 
	"snippet" => "( \${1:\$rows}, \${2:\$cols}, \${3:\$y}, \${4:\$x} )", 
	"desc" => "Create a new window", 
	"docurl" => "function.ncurses-newwin.html" 
),
"ncurses_nl" => array( 
	"methodname" => "ncurses_nl", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_nl ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Translate newline and carriage return / line feed", 
	"docurl" => "function.ncurses-nl.html" 
),
"ncurses_nocbreak" => array( 
	"methodname" => "ncurses_nocbreak", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_nocbreak ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Switch terminal to cooked mode", 
	"docurl" => "function.ncurses-nocbreak.html" 
),
"ncurses_noecho" => array( 
	"methodname" => "ncurses_noecho", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_noecho ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Switch off keyboard input echo", 
	"docurl" => "function.ncurses-noecho.html" 
),
"ncurses_nonl" => array( 
	"methodname" => "ncurses_nonl", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_nonl ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Do not translate newline and carriage return / line feed", 
	"docurl" => "function.ncurses-nonl.html" 
),
"ncurses_noqiflush" => array( 
	"methodname" => "ncurses_noqiflush", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_noqiflush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Do not flush on signal characters", 
	"docurl" => "function.ncurses-noqiflush.html" 
),
"ncurses_noraw" => array( 
	"methodname" => "ncurses_noraw", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_noraw ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Switch terminal out of raw mode", 
	"docurl" => "function.ncurses-noraw.html" 
),
"ncurses_pair_content" => array( 
	"methodname" => "ncurses_pair_content", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_pair_content ( int pair, int &f, int &b )", 
	"snippet" => "( \${1:\$pair}, \${2:\$f}, \${3:\$b} )", 
	"desc" => "Gets the RGB value for color", 
	"docurl" => "function.ncurses-pair-content.html" 
),
"ncurses_panel_above" => array( 
	"methodname" => "ncurses_panel_above", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_panel_above ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Returns the panel above panel", 
	"docurl" => "function.ncurses-panel-above.html" 
),
"ncurses_panel_below" => array( 
	"methodname" => "ncurses_panel_below", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_panel_below ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Returns the panel below panel", 
	"docurl" => "function.ncurses-panel-below.html" 
),
"ncurses_panel_window" => array( 
	"methodname" => "ncurses_panel_window", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_panel_window ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Returns the window associated with panel", 
	"docurl" => "function.ncurses-panel-window.html" 
),
"ncurses_pnoutrefresh" => array( 
	"methodname" => "ncurses_pnoutrefresh", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_pnoutrefresh ( resource pad, int pminrow, int pmincol, int sminrow, int smincol, int smaxrow, int smaxcol )", 
	"snippet" => "( \${1:\$pad}, \${2:\$pminrow}, \${3:\$pmincol}, \${4:\$sminrow}, \${5:\$smincol}, \${6:\$smaxrow}, \${7:\$smaxcol} )", 
	"desc" => "Copies a region from a pad into the virtual screen", 
	"docurl" => "function.ncurses-pnoutrefresh.html" 
),
"ncurses_prefresh" => array( 
	"methodname" => "ncurses_prefresh", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_prefresh ( resource pad, int pminrow, int pmincol, int sminrow, int smincol, int smaxrow, int smaxcol )", 
	"snippet" => "( \${1:\$pad}, \${2:\$pminrow}, \${3:\$pmincol}, \${4:\$sminrow}, \${5:\$smincol}, \${6:\$smaxrow}, \${7:\$smaxcol} )", 
	"desc" => "Copies a region from a pad into the virtual screen", 
	"docurl" => "function.ncurses-prefresh.html" 
),
"ncurses_putp" => array( 
	"methodname" => "ncurses_putp", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_putp ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Apply padding information to the string and output it", 
	"docurl" => "function.ncurses-putp.html" 
),
"ncurses_qiflush" => array( 
	"methodname" => "ncurses_qiflush", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_qiflush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush on signal characters", 
	"docurl" => "function.ncurses-qiflush.html" 
),
"ncurses_raw" => array( 
	"methodname" => "ncurses_raw", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_raw ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Switch terminal into raw mode", 
	"docurl" => "function.ncurses-raw.html" 
),
"ncurses_refresh" => array( 
	"methodname" => "ncurses_refresh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_refresh ( int ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Refresh screen", 
	"docurl" => "function.ncurses-refresh.html" 
),
"ncurses_replace_panel" => array( 
	"methodname" => "ncurses_replace_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_replace_panel ( resource panel, resource window )", 
	"snippet" => "( \${1:\$panel}, \${2:\$window} )", 
	"desc" => "Replaces the window associated with panel", 
	"docurl" => "function.ncurses-replace-panel.html" 
),
"ncurses_reset_prog_mode" => array( 
	"methodname" => "ncurses_reset_prog_mode", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_reset_prog_mode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Resets the prog mode saved by def_prog_mode", 
	"docurl" => "function.ncurses-reset-prog-mode.html" 
),
"ncurses_reset_shell_mode" => array( 
	"methodname" => "ncurses_reset_shell_mode", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_reset_shell_mode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Resets the shell mode saved by def_shell_mode", 
	"docurl" => "function.ncurses-reset-shell-mode.html" 
),
"ncurses_resetty" => array( 
	"methodname" => "ncurses_resetty", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_resetty ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restores saved terminal state", 
	"docurl" => "function.ncurses-resetty.html" 
),
"ncurses_savetty" => array( 
	"methodname" => "ncurses_savetty", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_savetty ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Saves terminal state", 
	"docurl" => "function.ncurses-savetty.html" 
),
"ncurses_scr_dump" => array( 
	"methodname" => "ncurses_scr_dump", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_scr_dump ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Dump screen content to file", 
	"docurl" => "function.ncurses-scr-dump.html" 
),
"ncurses_scr_init" => array( 
	"methodname" => "ncurses_scr_init", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_scr_init ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Initialize screen from file dump", 
	"docurl" => "function.ncurses-scr-init.html" 
),
"ncurses_scr_restore" => array( 
	"methodname" => "ncurses_scr_restore", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_scr_restore ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Restore screen from file dump", 
	"docurl" => "function.ncurses-scr-restore.html" 
),
"ncurses_scr_set" => array( 
	"methodname" => "ncurses_scr_set", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_scr_set ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Inherit screen from file dump", 
	"docurl" => "function.ncurses-scr-set.html" 
),
"ncurses_scrl" => array( 
	"methodname" => "ncurses_scrl", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_scrl ( int count )", 
	"snippet" => "( \${1:\$count} )", 
	"desc" => "Scroll window content up or down without changing current position", 
	"docurl" => "function.ncurses-scrl.html" 
),
"ncurses_show_panel" => array( 
	"methodname" => "ncurses_show_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_show_panel ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Places an invisible panel on top of the stack, making it visible", 
	"docurl" => "function.ncurses-show-panel.html" 
),
"ncurses_slk_attr" => array( 
	"methodname" => "ncurses_slk_attr", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_attr ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns current soft label key attribute", 
	"docurl" => "function.ncurses-slk-attr.html" 
),
"ncurses_slk_attroff" => array( 
	"methodname" => "ncurses_slk_attroff", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_slk_attroff ( int intarg )", 
	"snippet" => "( \${1:\$intarg} )", 
	"desc" => "Turn off the given attributes for soft function-key labels", 
	"docurl" => "function.ncurses-slk-attroff.html" 
),
"ncurses_slk_attron" => array( 
	"methodname" => "ncurses_slk_attron", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_slk_attron ( int intarg )", 
	"snippet" => "( \${1:\$intarg} )", 
	"desc" => "Turn on the given attributes for soft function-key labels", 
	"docurl" => "function.ncurses-slk-attron.html" 
),
"ncurses_slk_attrset" => array( 
	"methodname" => "ncurses_slk_attrset", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_slk_attrset ( int intarg )", 
	"snippet" => "( \${1:\$intarg} )", 
	"desc" => "Set given attributes for soft function-key labels", 
	"docurl" => "function.ncurses-slk-attrset.html" 
),
"ncurses_slk_clear" => array( 
	"methodname" => "ncurses_slk_clear", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_clear ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clears soft labels from screen", 
	"docurl" => "function.ncurses-slk-clear.html" 
),
"ncurses_slk_color" => array( 
	"methodname" => "ncurses_slk_color", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_slk_color ( int intarg )", 
	"snippet" => "( \${1:\$intarg} )", 
	"desc" => "Sets color for soft label keys", 
	"docurl" => "function.ncurses-slk-color.html" 
),
"ncurses_slk_init" => array( 
	"methodname" => "ncurses_slk_init", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_init ( int format )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Initializes soft label key functions", 
	"docurl" => "function.ncurses-slk-init.html" 
),
"ncurses_slk_noutrefresh" => array( 
	"methodname" => "ncurses_slk_noutrefresh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_noutrefresh ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Copies soft label keys to virtual screen", 
	"docurl" => "function.ncurses-slk-noutrefresh.html" 
),
"ncurses_slk_refresh" => array( 
	"methodname" => "ncurses_slk_refresh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_refresh ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Copies soft label keys to screen", 
	"docurl" => "function.ncurses-slk-refresh.html" 
),
"ncurses_slk_restore" => array( 
	"methodname" => "ncurses_slk_restore", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_restore ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restores soft label keys", 
	"docurl" => "function.ncurses-slk-restore.html" 
),
"ncurses_slk_set" => array( 
	"methodname" => "ncurses_slk_set", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ncurses_slk_set ( int labelnr, string label, int format )", 
	"snippet" => "( \${1:\$labelnr}, \${2:\$label}, \${3:\$format} )", 
	"desc" => "Sets function key labels", 
	"docurl" => "function.ncurses-slk-set.html" 
),
"ncurses_slk_touch" => array( 
	"methodname" => "ncurses_slk_touch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_slk_touch ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Forces output when ncurses_slk_noutrefresh is performed", 
	"docurl" => "function.ncurses-slk-touch.html" 
),
"ncurses_standend" => array( 
	"methodname" => "ncurses_standend", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_standend ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Stop using \'standout\' attribute", 
	"docurl" => "function.ncurses-standend.html" 
),
"ncurses_standout" => array( 
	"methodname" => "ncurses_standout", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_standout ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Start using \'standout\' attribute", 
	"docurl" => "function.ncurses-standout.html" 
),
"ncurses_start_color" => array( 
	"methodname" => "ncurses_start_color", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_start_color ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Start using colors", 
	"docurl" => "function.ncurses-start-color.html" 
),
"ncurses_termattrs" => array( 
	"methodname" => "ncurses_termattrs", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_termattrs ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns a logical OR of all attribute flags supported by terminal", 
	"docurl" => "function.ncurses-termattrs.html" 
),
"ncurses_termname" => array( 
	"methodname" => "ncurses_termname", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string ncurses_termname ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns terminals (short)-name", 
	"docurl" => "function.ncurses-termname.html" 
),
"ncurses_timeout" => array( 
	"methodname" => "ncurses_timeout", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "void ncurses_timeout ( int millisec )", 
	"snippet" => "( \${1:\$millisec} )", 
	"desc" => "Set timeout for special key sequences", 
	"docurl" => "function.ncurses-timeout.html" 
),
"ncurses_top_panel" => array( 
	"methodname" => "ncurses_top_panel", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_top_panel ( resource panel )", 
	"snippet" => "( \${1:\$panel} )", 
	"desc" => "Moves a visible panel to the top of the stack", 
	"docurl" => "function.ncurses-top-panel.html" 
),
"ncurses_typeahead" => array( 
	"methodname" => "ncurses_typeahead", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_typeahead ( int fd )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Specify different filedescriptor for typeahead checking", 
	"docurl" => "function.ncurses-typeahead.html" 
),
"ncurses_ungetch" => array( 
	"methodname" => "ncurses_ungetch", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_ungetch ( int keycode )", 
	"snippet" => "( \${1:\$keycode} )", 
	"desc" => "Put a character back into the input stream", 
	"docurl" => "function.ncurses-ungetch.html" 
),
"ncurses_ungetmouse" => array( 
	"methodname" => "ncurses_ungetmouse", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ncurses_ungetmouse ( array mevent )", 
	"snippet" => "( \${1:\$mevent} )", 
	"desc" => "Pushes mouse event to queue", 
	"docurl" => "function.ncurses-ungetmouse.html" 
),
"ncurses_update_panels" => array( 
	"methodname" => "ncurses_update_panels", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void ncurses_update_panels ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Refreshes the virtual screen to reflect the relations between panels in the stack", 
	"docurl" => "function.ncurses-update-panels.html" 
),
"ncurses_use_default_colors" => array( 
	"methodname" => "ncurses_use_default_colors", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ncurses_use_default_colors ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Assign terminal default colors to color id -1", 
	"docurl" => "function.ncurses-use-default-colors.html" 
),
"ncurses_use_env" => array( 
	"methodname" => "ncurses_use_env", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "void ncurses_use_env ( bool flag )", 
	"snippet" => "( \${1:\$flag} )", 
	"desc" => "Control use of environment information about terminal size", 
	"docurl" => "function.ncurses-use-env.html" 
),
"ncurses_use_extended_names" => array( 
	"methodname" => "ncurses_use_extended_names", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_use_extended_names ( bool flag )", 
	"snippet" => "( \${1:\$flag} )", 
	"desc" => "Control use of extended names in terminfo descriptions", 
	"docurl" => "function.ncurses-use-extended-names.html" 
),
"ncurses_vidattr" => array( 
	"methodname" => "ncurses_vidattr", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int ncurses_vidattr ( int intarg )", 
	"snippet" => "( \${1:\$intarg} )", 
	"desc" => "Display the string on the terminal in the video attribute mode", 
	"docurl" => "function.ncurses-vidattr.html" 
),
"ncurses_vline" => array( 
	"methodname" => "ncurses_vline", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_vline ( int charattr, int n )", 
	"snippet" => "( \${1:\$charattr}, \${2:\$n} )", 
	"desc" => "Draw a vertical line at current position using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-vline.html" 
),
"ncurses_waddch" => array( 
	"methodname" => "ncurses_waddch", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_waddch ( resource window, int ch )", 
	"snippet" => "( \${1:\$window}, \${2:\$ch} )", 
	"desc" => "Adds character at current position in a window and advance cursor", 
	"docurl" => "function.ncurses-waddch.html" 
),
"ncurses_waddstr" => array( 
	"methodname" => "ncurses_waddstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_waddstr ( resource window, string str [, int n] )", 
	"snippet" => "( \${1:\$window}, \${2:\$str} )", 
	"desc" => "Outputs text at current postion in window", 
	"docurl" => "function.ncurses-waddstr.html" 
),
"ncurses_wattroff" => array( 
	"methodname" => "ncurses_wattroff", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wattroff ( resource window, int attrs )", 
	"snippet" => "( \${1:\$window}, \${2:\$attrs} )", 
	"desc" => "Turns off attributes for a window", 
	"docurl" => "function.ncurses-wattroff.html" 
),
"ncurses_wattron" => array( 
	"methodname" => "ncurses_wattron", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wattron ( resource window, int attrs )", 
	"snippet" => "( \${1:\$window}, \${2:\$attrs} )", 
	"desc" => "Turns on attributes for a window", 
	"docurl" => "function.ncurses-wattron.html" 
),
"ncurses_wattrset" => array( 
	"methodname" => "ncurses_wattrset", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wattrset ( resource window, int attrs )", 
	"snippet" => "( \${1:\$window}, \${2:\$attrs} )", 
	"desc" => "Set the attributes for a window", 
	"docurl" => "function.ncurses-wattrset.html" 
),
"ncurses_wborder" => array( 
	"methodname" => "ncurses_wborder", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wborder ( resource window, int left, int right, int top, int bottom, int tl_corner, int tr_corner, int bl_corner, int br_corner )", 
	"snippet" => "( \${1:\$window}, \${2:\$left}, \${3:\$right}, \${4:\$top}, \${5:\$bottom}, \${6:\$tl_corner}, \${7:\$tr_corner}, \${8:\$bl_corner}, \${9:\$br_corner} )", 
	"desc" => "Draws a border around the window using attributed characters", 
	"docurl" => "function.ncurses-wborder.html" 
),
"ncurses_wclear" => array( 
	"methodname" => "ncurses_wclear", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wclear ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Clears window", 
	"docurl" => "function.ncurses-wclear.html" 
),
"ncurses_wcolor_set" => array( 
	"methodname" => "ncurses_wcolor_set", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wcolor_set ( resource window, int color_pair )", 
	"snippet" => "( \${1:\$window}, \${2:\$color_pair} )", 
	"desc" => "Sets windows color pairings", 
	"docurl" => "function.ncurses-wcolor-set.html" 
),
"ncurses_werase" => array( 
	"methodname" => "ncurses_werase", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_werase ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Erase window contents", 
	"docurl" => "function.ncurses-werase.html" 
),
"ncurses_wgetch" => array( 
	"methodname" => "ncurses_wgetch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wgetch ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Reads a character from keyboard (window)", 
	"docurl" => "function.ncurses-wgetch.html" 
),
"ncurses_whline" => array( 
	"methodname" => "ncurses_whline", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_whline ( resource window, int charattr, int n )", 
	"snippet" => "( \${1:\$window}, \${2:\$charattr}, \${3:\$n} )", 
	"desc" => "Draws a horizontal line in a window at current position using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-whline.html" 
),
"ncurses_wmouse_trafo" => array( 
	"methodname" => "ncurses_wmouse_trafo", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ncurses_wmouse_trafo ( resource window, int &y, int &x, bool toscreen )", 
	"snippet" => "( \${1:\$window}, \${2:\$y}, \${3:\$x}, \${4:\$toscreen} )", 
	"desc" => "Transforms window/stdscr coordinates", 
	"docurl" => "function.ncurses-wmouse-trafo.html" 
),
"ncurses_wmove" => array( 
	"methodname" => "ncurses_wmove", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wmove ( resource window, int y, int x )", 
	"snippet" => "( \${1:\$window}, \${2:\$y}, \${3:\$x} )", 
	"desc" => "Moves windows output position", 
	"docurl" => "function.ncurses-wmove.html" 
),
"ncurses_wnoutrefresh" => array( 
	"methodname" => "ncurses_wnoutrefresh", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wnoutrefresh ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Copies window to virtual screen", 
	"docurl" => "function.ncurses-wnoutrefresh.html" 
),
"ncurses_wrefresh" => array( 
	"methodname" => "ncurses_wrefresh", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ncurses_wrefresh ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Refresh window on terminal screen", 
	"docurl" => "function.ncurses-wrefresh.html" 
),
"ncurses_wstandend" => array( 
	"methodname" => "ncurses_wstandend", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wstandend ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "End standout mode for a window", 
	"docurl" => "function.ncurses-wstandend.html" 
),
"ncurses_wstandout" => array( 
	"methodname" => "ncurses_wstandout", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wstandout ( resource window )", 
	"snippet" => "( \${1:\$window} )", 
	"desc" => "Enter standout mode for a window", 
	"docurl" => "function.ncurses-wstandout.html" 
),
"ncurses_wvline" => array( 
	"methodname" => "ncurses_wvline", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ncurses_wvline ( resource window, int charattr, int n )", 
	"snippet" => "( \${1:\$window}, \${2:\$charattr}, \${3:\$n} )", 
	"desc" => "Draws a vertical line in a window at current position using an attributed character and max. n characters long", 
	"docurl" => "function.ncurses-wvline.html" 
),
"next" => array( 
	"methodname" => "next", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed next ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Advance the internal array pointer of an array", 
	"docurl" => "function.next.html" 
),
"ngettext" => array( 
	"methodname" => "ngettext", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string ngettext ( string msgid1, string msgid2, int n )", 
	"snippet" => "( \${1:\$msgid1}, \${2:\$msgid2}, \${3:\$n} )", 
	"desc" => "Plural version of gettext", 
	"docurl" => "function.ngettext.html" 
),
"nl_langinfo" => array( 
	"methodname" => "nl_langinfo", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string nl_langinfo ( int item )", 
	"snippet" => "( \${1:\$item} )", 
	"desc" => "Query language and locale information", 
	"docurl" => "function.nl-langinfo.html" 
),
"nl2br" => array( 
	"methodname" => "nl2br", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string nl2br ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Inserts HTML line breaks before all newlines in a string", 
	"docurl" => "function.nl2br.html" 
),
"notes_body" => array( 
	"methodname" => "notes_body", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "array notes_body ( string server, string mailbox, int msg_number )", 
	"snippet" => "( \${1:\$server}, \${2:\$mailbox}, \${3:\$msg_number} )", 
	"desc" => "Open the message msg_number in the specified mailbox on the specified server (leave serv", 
	"docurl" => "function.notes-body.html" 
),
"notes_copy_db" => array( 
	"methodname" => "notes_copy_db", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_copy_db ( string from_database_name, string to_database_name )", 
	"snippet" => "( \${1:\$from_database_name}, \${2:\$to_database_name} )", 
	"desc" => "Copy a Lotus Notes database", 
	"docurl" => "function.notes-copy-db.html" 
),
"notes_create_db" => array( 
	"methodname" => "notes_create_db", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool notes_create_db ( string database_name )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Create a Lotus Notes database", 
	"docurl" => "function.notes-create-db.html" 
),
"notes_create_note" => array( 
	"methodname" => "notes_create_note", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_create_note ( string database_name, string form_name )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$form_name} )", 
	"desc" => "Create a note using form form_name", 
	"docurl" => "function.notes-create-note.html" 
),
"notes_drop_db" => array( 
	"methodname" => "notes_drop_db", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool notes_drop_db ( string database_name )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Drop a Lotus Notes database", 
	"docurl" => "function.notes-drop-db.html" 
),
"notes_find_note" => array( 
	"methodname" => "notes_find_note", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool notes_find_note ( string database_name, string name [, string type] )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$name} )", 
	"desc" => "Returns a note id found in database_name", 
	"docurl" => "function.notes-find-note.html" 
),
"notes_header_info" => array( 
	"methodname" => "notes_header_info", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "object notes_header_info ( string server, string mailbox, int msg_number )", 
	"snippet" => "( \${1:\$server}, \${2:\$mailbox}, \${3:\$msg_number} )", 
	"desc" => "Open the message msg_number in the specified mailbox on the specified server (leave serv", 
	"docurl" => "function.notes-header-info.html" 
),
"notes_list_msgs" => array( 
	"methodname" => "notes_list_msgs", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool notes_list_msgs ( string db )", 
	"snippet" => "( \${1:\$db} )", 
	"desc" => "Returns the notes from a selected database_name", 
	"docurl" => "function.notes-list-msgs.html" 
),
"notes_mark_read" => array( 
	"methodname" => "notes_mark_read", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_mark_read ( string database_name, string user_name, string note_id )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$user_name}, \${3:\$note_id} )", 
	"desc" => "Mark a note_id as read for the User user_name", 
	"docurl" => "function.notes-mark-read.html" 
),
"notes_mark_unread" => array( 
	"methodname" => "notes_mark_unread", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_mark_unread ( string database_name, string user_name, string note_id )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$user_name}, \${3:\$note_id} )", 
	"desc" => "Mark a note_id as unread for the User user_name", 
	"docurl" => "function.notes-mark-unread.html" 
),
"notes_nav_create" => array( 
	"methodname" => "notes_nav_create", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool notes_nav_create ( string database_name, string name )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$name} )", 
	"desc" => "Create a navigator name, in database_name", 
	"docurl" => "function.notes-nav-create.html" 
),
"notes_search" => array( 
	"methodname" => "notes_search", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_search ( string database_name, string keywords )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$keywords} )", 
	"desc" => "Find notes that match keywords in database_name", 
	"docurl" => "function.notes-search.html" 
),
"notes_unread" => array( 
	"methodname" => "notes_unread", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_unread ( string database_name, string user_name )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$user_name} )", 
	"desc" => "Returns the unread note id\'s for the current User user_name", 
	"docurl" => "function.notes-unread.html" 
),
"notes_version" => array( 
	"methodname" => "notes_version", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string notes_version ( string database_name )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Get the version Lotus Notes", 
	"docurl" => "function.notes-version.html" 
),
"nsapi_request_headers" => array( 
	"methodname" => "nsapi_request_headers", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "array nsapi_request_headers ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Fetch all HTTP request headers", 
	"docurl" => "function.nsapi-request-headers.html" 
),
"nsapi_response_headers" => array( 
	"methodname" => "nsapi_response_headers", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "array nsapi_response_headers ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Fetch all HTTP response headers", 
	"docurl" => "function.nsapi-response-headers.html" 
),
"nsapi_virtual" => array( 
	"methodname" => "nsapi_virtual", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool nsapi_virtual ( string uri )", 
	"snippet" => "( \${1:\$uri} )", 
	"desc" => "Perform an NSAPI sub-request", 
	"docurl" => "function.nsapi-virtual.html" 
),
"number_format" => array( 
	"methodname" => "number_format", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string number_format ( float number [, int decimals [, string dec_point, string thousands_sep]] )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Format a number with grouped thousands", 
	"docurl" => "function.number-format.html" 
),
); # end of main array
?>