<?php
$_LOOKUP = array( 
"pack" => array( 
	"methodname" => "pack", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string pack ( string format [, mixed args [, mixed ...]] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Pack data into binary string", 
	"docurl" => "function.pack.html" 
),
"parse_ini_file" => array( 
	"methodname" => "parse_ini_file", 
	"version" => "PHP4, PHP5", 
	"method" => "array parse_ini_file ( string filename [, bool process_sections] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Parse a configuration file", 
	"docurl" => "function.parse-ini-file.html" 
),
"parse_str" => array( 
	"methodname" => "parse_str", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void parse_str ( string str [, array &arr] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Parses the string into variables", 
	"docurl" => "function.parse-str.html" 
),
"parse_url" => array( 
	"methodname" => "parse_url", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array parse_url ( string url )", 
	"snippet" => "( \${1:\$url} )", 
	"desc" => "Parse a URL and return its components", 
	"docurl" => "function.parse-url.html" 
),
"parsekit_compile_file" => array( 
	"methodname" => "parsekit_compile_file", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array parsekit_compile_file ( string filename [, array &errors [, int options]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Compile a string of PHP code and return the resulting op array", 
	"docurl" => "function.parsekit-compile-file.html" 
),
"parsekit_compile_string" => array( 
	"methodname" => "parsekit_compile_string", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array parsekit_compile_string ( string phpcode [, array &errors [, int options]] )", 
	"snippet" => "( \${1:\$phpcode} )", 
	"desc" => "Compile a string of PHP code and return the resulting op array", 
	"docurl" => "function.parsekit-compile-string.html" 
),
"parsekit_func_arginfo" => array( 
	"methodname" => "parsekit_func_arginfo", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array parsekit_func_arginfo ( mixed function )", 
	"snippet" => "( \${1:\$function} )", 
	"desc" => "Return information regarding function argument(s)", 
	"docurl" => "function.parsekit-func-arginfo.html" 
),
"passthru" => array( 
	"methodname" => "passthru", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void passthru ( string command [, int &return_var] )", 
	"snippet" => "( \${1:\$command} )", 
	"desc" => "Execute an external program and display raw output", 
	"docurl" => "function.passthru.html" 
),
"pathinfo" => array( 
	"methodname" => "pathinfo", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "array pathinfo ( string path [, int options] )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Returns information about a file path", 
	"docurl" => "function.pathinfo.html" 
),
"pclose" => array( 
	"methodname" => "pclose", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int pclose ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Closes process file pointer", 
	"docurl" => "function.pclose.html" 
),
"pcntl_alarm" => array( 
	"methodname" => "pcntl_alarm", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int pcntl_alarm ( int seconds )", 
	"snippet" => "( \${1:\$seconds} )", 
	"desc" => "Set an alarm clock for delivery of a signal", 
	"docurl" => "function.pcntl-alarm.html" 
),
"pcntl_exec" => array( 
	"methodname" => "pcntl_exec", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pcntl_exec ( string path [, array args [, array envs]] )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Executes specified program in current process space", 
	"docurl" => "function.pcntl-exec.html" 
),
"pcntl_fork" => array( 
	"methodname" => "pcntl_fork", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_fork ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Forks the currently running process", 
	"docurl" => "function.pcntl-fork.html" 
),
"pcntl_getpriority" => array( 
	"methodname" => "pcntl_getpriority", 
	"version" => "PHP5", 
	"method" => "int pcntl_getpriority ( [int pid [, int process_identifier]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the priority of any process", 
	"docurl" => "function.pcntl-getpriority.html" 
),
"pcntl_setpriority" => array( 
	"methodname" => "pcntl_setpriority", 
	"version" => "PHP5", 
	"method" => "bool pcntl_setpriority ( int priority [, int pid [, int process_identifier]] )", 
	"snippet" => "( \${1:\$priority} )", 
	"desc" => "Change the priority of any process", 
	"docurl" => "function.pcntl-setpriority.html" 
),
"pcntl_signal" => array( 
	"methodname" => "pcntl_signal", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool pcntl_signal ( int signo, callback handle [, bool restart_syscalls] )", 
	"snippet" => "( \${1:\$signo}, \${2:\$handle} )", 
	"desc" => "Installs a signal handler", 
	"docurl" => "function.pcntl-signal.html" 
),
"pcntl_wait" => array( 
	"methodname" => "pcntl_wait", 
	"version" => "PHP5", 
	"method" => "int pcntl_wait ( int &status [, int options] )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Waits on or returns the status of a forked child", 
	"docurl" => "function.pcntl-wait.html" 
),
"pcntl_waitpid" => array( 
	"methodname" => "pcntl_waitpid", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_waitpid ( int pid, int &status [, int options] )", 
	"snippet" => "( \${1:\$pid}, \${2:\$status} )", 
	"desc" => "Waits on or returns the status of a forked child", 
	"docurl" => "function.pcntl-waitpid.html" 
),
"pcntl_wexitstatus" => array( 
	"methodname" => "pcntl_wexitstatus", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wexitstatus ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns the return code of a terminated child", 
	"docurl" => "function.pcntl-wexitstatus.html" 
),
"pcntl_wifexited" => array( 
	"methodname" => "pcntl_wifexited", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wifexited ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns TRUE if status code represents a successful exit", 
	"docurl" => "function.pcntl-wifexited.html" 
),
"pcntl_wifsignaled" => array( 
	"methodname" => "pcntl_wifsignaled", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wifsignaled ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns TRUE if status code represents a termination due to a   signal", 
	"docurl" => "function.pcntl-wifsignaled.html" 
),
"pcntl_wifstopped" => array( 
	"methodname" => "pcntl_wifstopped", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wifstopped ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns TRUE if child process is currently stopped", 
	"docurl" => "function.pcntl-wifstopped.html" 
),
"pcntl_wstopsig" => array( 
	"methodname" => "pcntl_wstopsig", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wstopsig ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns the signal which caused the child to stop", 
	"docurl" => "function.pcntl-wstopsig.html" 
),
"pcntl_wtermsig" => array( 
	"methodname" => "pcntl_wtermsig", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int pcntl_wtermsig ( int status )", 
	"snippet" => "( \${1:\$status} )", 
	"desc" => "Returns the signal which caused the child to terminate", 
	"docurl" => "function.pcntl-wtermsig.html" 
),
"pdf_add_bookmark" => array( 
	"methodname" => "pdf_add_bookmark", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int pdf_add_bookmark ( resource pdfdoc, string text, int parent, int open )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text}, \${3:\$parent}, \${4:\$open} )", 
	"desc" => "Adds bookmark for current page", 
	"docurl" => "function.pdf-add-bookmark.html" 
),
"pdf_add_launchlink" => array( 
	"methodname" => "pdf_add_launchlink", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_add_launchlink ( resource pdfdoc, float llx, float lly, float urx, float ury, string filename )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$llx}, \${3:\$lly}, \${4:\$urx}, \${5:\$ury}, \${6:\$filename} )", 
	"desc" => "Add a launch annotation for current page", 
	"docurl" => "function.pdf-add-launchlink.html" 
),
"pdf_add_locallink" => array( 
	"methodname" => "pdf_add_locallink", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_add_locallink ( resource pdfdoc, float lowerleftx, float lowerlefty, float upperrightx, float upperrighty, int page, string dest )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$lowerleftx}, \${3:\$lowerlefty}, \${4:\$upperrightx}, \${5:\$upperrighty}, \${6:\$page}, \${7:\$dest} )", 
	"desc" => "Add a link annotation for current page", 
	"docurl" => "function.pdf-add-locallink.html" 
),
"pdf_add_note" => array( 
	"methodname" => "pdf_add_note", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_add_note ( resource pdfdoc, float llx, float lly, float urx, float ury, string contents, string title, string icon, int open )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$llx}, \${3:\$lly}, \${4:\$urx}, \${5:\$ury}, \${6:\$contents}, \${7:\$title}, \${8:\$icon}, \${9:\$open} )", 
	"desc" => "Sets annotation for current page", 
	"docurl" => "function.pdf-add-note.html" 
),
"pdf_add_pdflink" => array( 
	"methodname" => "pdf_add_pdflink", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool pdf_add_pdflink ( resource pdfdoc, float bottom_left_x, float bottom_left_y, float up_right_x, float up_right_y, string filename, int page, string dest )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$bottom_left_x}, \${3:\$bottom_left_y}, \${4:\$up_right_x}, \${5:\$up_right_y}, \${6:\$filename}, \${7:\$page}, \${8:\$dest} )", 
	"desc" => "Adds file link annotation for current page", 
	"docurl" => "function.pdf-add-pdflink.html" 
),
"pdf_add_thumbnail" => array( 
	"methodname" => "pdf_add_thumbnail", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_add_thumbnail ( resource pdfdoc, int image )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$image} )", 
	"desc" => "Adds thumbnail for current page", 
	"docurl" => "function.pdf-add-thumbnail.html" 
),
"pdf_add_weblink" => array( 
	"methodname" => "pdf_add_weblink", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool pdf_add_weblink ( resource pdfdoc, float lowerleftx, float lowerlefty, float upperrightx, float upperrighty, string url )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$lowerleftx}, \${3:\$lowerlefty}, \${4:\$upperrightx}, \${5:\$upperrighty}, \${6:\$url} )", 
	"desc" => "Adds weblink for current page", 
	"docurl" => "function.pdf-add-weblink.html" 
),
"pdf_arc" => array( 
	"methodname" => "pdf_arc", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_arc ( resource pdfdoc, float x, float y, float r, float alpha, float beta )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y}, \${4:\$r}, \${5:\$alpha}, \${6:\$beta} )", 
	"desc" => "Draws an arc (counterclockwise)", 
	"docurl" => "function.pdf-arc.html" 
),
"pdf_arcn" => array( 
	"methodname" => "pdf_arcn", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_arcn ( resource pdfdoc, float x, float y, float r, float alpha, float beta )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y}, \${4:\$r}, \${5:\$alpha}, \${6:\$beta} )", 
	"desc" => "Draws an arc (clockwise)", 
	"docurl" => "function.pdf-arcn.html" 
),
"pdf_attach_file" => array( 
	"methodname" => "pdf_attach_file", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_attach_file ( resource pdfdoc, float llx, float lly, float urx, float ury, string filename, string description, string author, string mimetype, string icon )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$llx}, \${3:\$lly}, \${4:\$urx}, \${5:\$ury}, \${6:\$filename}, \${7:\$description}, \${8:\$author}, \${9:\$mimetype}, \${10:\$icon} )", 
	"desc" => "Adds a file attachment for current page", 
	"docurl" => "function.pdf-attach-file.html" 
),
"pdf_begin_page" => array( 
	"methodname" => "pdf_begin_page", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_begin_page ( resource pdfdoc, float width, float height )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$width}, \${3:\$height} )", 
	"desc" => "Starts new page", 
	"docurl" => "function.pdf-begin-page.html" 
),
"pdf_begin_pattern" => array( 
	"methodname" => "pdf_begin_pattern", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_begin_pattern ( resource pdfdoc, float width, float height, float xstep, float ystep, int painttype )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$width}, \${3:\$height}, \${4:\$xstep}, \${5:\$ystep}, \${6:\$painttype} )", 
	"desc" => "Starts new pattern", 
	"docurl" => "function.pdf-begin-pattern.html" 
),
"pdf_begin_template" => array( 
	"methodname" => "pdf_begin_template", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_begin_template ( resource pdfdoc, float width, float height )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$width}, \${3:\$height} )", 
	"desc" => "Starts new template", 
	"docurl" => "function.pdf-begin-template.html" 
),
"pdf_circle" => array( 
	"methodname" => "pdf_circle", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_circle ( resource pdfdoc, float x, float y, float r )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y}, \${4:\$r} )", 
	"desc" => "Draws a circle", 
	"docurl" => "function.pdf-circle.html" 
),
"pdf_clip" => array( 
	"methodname" => "pdf_clip", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_clip ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Clips to current path", 
	"docurl" => "function.pdf-clip.html" 
),
"pdf_close_image" => array( 
	"methodname" => "pdf_close_image", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "void pdf_close_image ( resource pdfdoc, int image )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$image} )", 
	"desc" => "Closes an image", 
	"docurl" => "function.pdf-close-image.html" 
),
"pdf_close_pdi_page" => array( 
	"methodname" => "pdf_close_pdi_page", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_close_pdi_page ( resource pdfdoc, int pagehandle )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$pagehandle} )", 
	"desc" => "Close the page handle", 
	"docurl" => "function.pdf-close-pdi-page.html" 
),
"pdf_close_pdi" => array( 
	"methodname" => "pdf_close_pdi", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_close_pdi ( resource pdfdoc, int dochandle )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$dochandle} )", 
	"desc" => "Close the input PDF document", 
	"docurl" => "function.pdf-close-pdi.html" 
),
"pdf_close" => array( 
	"methodname" => "pdf_close", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_close ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Closes a pdf resource", 
	"docurl" => "function.pdf-close.html" 
),
"pdf_closepath_fill_stroke" => array( 
	"methodname" => "pdf_closepath_fill_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_closepath_fill_stroke ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Closes, fills and strokes current path", 
	"docurl" => "function.pdf-closepath-fill-stroke.html" 
),
"pdf_closepath_stroke" => array( 
	"methodname" => "pdf_closepath_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_closepath_stroke ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Closes path and draws line along path", 
	"docurl" => "function.pdf-closepath-stroke.html" 
),
"pdf_closepath" => array( 
	"methodname" => "pdf_closepath", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_closepath ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Closes path", 
	"docurl" => "function.pdf-closepath.html" 
),
"pdf_concat" => array( 
	"methodname" => "pdf_concat", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_concat ( resource pdfdoc, float a, float b, float c, float d, float e, float f )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$a}, \${3:\$b}, \${4:\$c}, \${5:\$d}, \${6:\$e}, \${7:\$f} )", 
	"desc" => "Concatenate a matrix to the CTM", 
	"docurl" => "function.pdf-concat.html" 
),
"pdf_continue_text" => array( 
	"methodname" => "pdf_continue_text", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_continue_text ( resource pdfdoc, string text )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text} )", 
	"desc" => "Outputs text in next line", 
	"docurl" => "function.pdf-continue-text.html" 
),
"pdf_curveto" => array( 
	"methodname" => "pdf_curveto", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_curveto ( resource pdfdoc, float x1, float y1, float x2, float y2, float x3, float y3 )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$x3}, \${7:\$y3} )", 
	"desc" => "Draws a curve", 
	"docurl" => "function.pdf-curveto.html" 
),
"pdf_delete" => array( 
	"methodname" => "pdf_delete", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_delete ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Deletes a PDF object", 
	"docurl" => "function.pdf-delete.html" 
),
"pdf_end_page" => array( 
	"methodname" => "pdf_end_page", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_end_page ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Ends a page", 
	"docurl" => "function.pdf-end-page.html" 
),
"pdf_end_pattern" => array( 
	"methodname" => "pdf_end_pattern", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_end_pattern ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Finish pattern", 
	"docurl" => "function.pdf-end-pattern.html" 
),
"pdf_end_template" => array( 
	"methodname" => "pdf_end_template", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_end_template ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Finish template", 
	"docurl" => "function.pdf-end-template.html" 
),
"pdf_fill_stroke" => array( 
	"methodname" => "pdf_fill_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_fill_stroke ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Fills and strokes current path", 
	"docurl" => "function.pdf-fill-stroke.html" 
),
"pdf_fill" => array( 
	"methodname" => "pdf_fill", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_fill ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Fills current path", 
	"docurl" => "function.pdf-fill.html" 
),
"pdf_findfont" => array( 
	"methodname" => "pdf_findfont", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_findfont ( resource pdfdoc, string fontname, string encoding, int embed )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$fontname}, \${3:\$encoding}, \${4:\$embed} )", 
	"desc" => "Prepare font for later use with pdf_setfont()", 
	"docurl" => "function.pdf-findfont.html" 
),
"pdf_get_buffer" => array( 
	"methodname" => "pdf_get_buffer", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string pdf_get_buffer ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Fetch the buffer containing the generated PDF data", 
	"docurl" => "function.pdf-get-buffer.html" 
),
"pdf_get_majorversion" => array( 
	"methodname" => "pdf_get_majorversion", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pdf_get_majorversion ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the major version number of the PDFlib", 
	"docurl" => "function.pdf-get-majorversion.html" 
),
"pdf_get_minorversion" => array( 
	"methodname" => "pdf_get_minorversion", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pdf_get_minorversion ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the minor version number of the PDFlib", 
	"docurl" => "function.pdf-get-minorversion.html" 
),
"pdf_get_parameter" => array( 
	"methodname" => "pdf_get_parameter", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string pdf_get_parameter ( resource pdfdoc, string key, float modifier )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$modifier} )", 
	"desc" => "Gets certain parameters", 
	"docurl" => "function.pdf-get-parameter.html" 
),
"pdf_get_pdi_parameter" => array( 
	"methodname" => "pdf_get_pdi_parameter", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string pdf_get_pdi_parameter ( resource pdfdoc, string key, int document, int page, int index )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$document}, \${4:\$page}, \${5:\$index} )", 
	"desc" => "Get some PDI string parameters", 
	"docurl" => "function.pdf-get-pdi-parameter.html" 
),
"pdf_get_pdi_value" => array( 
	"methodname" => "pdf_get_pdi_value", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string pdf_get_pdi_value ( resource pdfdoc, string key, int doc, int page, int index )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$doc}, \${4:\$page}, \${5:\$index} )", 
	"desc" => "Gets some PDI numerical parameters", 
	"docurl" => "function.pdf-get-pdi-value.html" 
),
"pdf_get_value" => array( 
	"methodname" => "pdf_get_value", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "float pdf_get_value ( resource pdfdoc, string key, float modifier )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$modifier} )", 
	"desc" => "Gets certain numerical value", 
	"docurl" => "function.pdf-get-value.html" 
),
"pdf_initgraphics" => array( 
	"methodname" => "pdf_initgraphics", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_initgraphics ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Resets graphic state", 
	"docurl" => "function.pdf-initgraphics.html" 
),
"pdf_lineto" => array( 
	"methodname" => "pdf_lineto", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_lineto ( resource pdfdoc, float x, float y )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y} )", 
	"desc" => "Draws a line", 
	"docurl" => "function.pdf-lineto.html" 
),
"pdf_makespotcolor" => array( 
	"methodname" => "pdf_makespotcolor", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_makespotcolor ( resource pdfdoc, string spotname )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$spotname} )", 
	"desc" => "Makes a spotcolor", 
	"docurl" => "function.pdf-makespotcolor.html" 
),
"pdf_moveto" => array( 
	"methodname" => "pdf_moveto", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_moveto ( resource pdfdoc, float x, float y )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y} )", 
	"desc" => "Sets current point", 
	"docurl" => "function.pdf-moveto.html" 
),
"pdf_new" => array( 
	"methodname" => "pdf_new", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource pdf_new (  )", 
	"snippet" => "( \$1 )", 
	"desc" => "Creates a new pdf resource", 
	"docurl" => "function.pdf-new.html" 
),
"pdf_open_ccitt" => array( 
	"methodname" => "pdf_open_ccitt", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_open_ccitt ( resource pdfdoc, string filename, int width, int height, int BitReverse, int k, int Blackls1 )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$filename}, \${3:\$width}, \${4:\$height}, \${5:\$BitReverse}, \${6:\$k}, \${7:\$Blackls1} )", 
	"desc" => "Opens a new image file with raw CCITT data", 
	"docurl" => "function.pdf-open-ccitt.html" 
),
"pdf_open_file" => array( 
	"methodname" => "pdf_open_file", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_open_file ( resource pdfdoc, string filename )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$filename} )", 
	"desc" => "Opens a new pdf object", 
	"docurl" => "function.pdf-open-file.html" 
),
"pdf_open_image_file" => array( 
	"methodname" => "pdf_open_image_file", 
	"version" => "PHP3 CVS only, PHP4, PHP5", 
	"method" => "int pdf_open_image_file ( resource pdfdoc, string imagetype, string filename, string stringparam, int intparam )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$imagetype}, \${3:\$filename}, \${4:\$stringparam}, \${5:\$intparam} )", 
	"desc" => "Reads an image from a file", 
	"docurl" => "function.pdf-open-image-file.html" 
),
"pdf_open_image" => array( 
	"methodname" => "pdf_open_image", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_open_image ( resource pdfdoc, string imagetype, string source, string data, int length, int width, int height, int components, int bpc, string params )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$imagetype}, \${3:\$source}, \${4:\$data}, \${5:\$length}, \${6:\$width}, \${7:\$height}, \${8:\$components}, \${9:\$bpc}, \${10:\$params} )", 
	"desc" => "Versatile function for images", 
	"docurl" => "function.pdf-open-image.html" 
),
"pdf_open_memory_image" => array( 
	"methodname" => "pdf_open_memory_image", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int pdf_open_memory_image ( resource pdfdoc, resource image )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$image} )", 
	"desc" => "Opens an image created with PHP\'s image functions", 
	"docurl" => "function.pdf-open-memory-image.html" 
),
"pdf_open_pdi_page" => array( 
	"methodname" => "pdf_open_pdi_page", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_open_pdi_page ( resource pdfdoc, int dochandle, int pagenumber, string pagelabel )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$dochandle}, \${3:\$pagenumber}, \${4:\$pagelabel} )", 
	"desc" => "Prepare a page", 
	"docurl" => "function.pdf-open-pdi-page.html" 
),
"pdf_open_pdi" => array( 
	"methodname" => "pdf_open_pdi", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int pdf_open_pdi ( resource pdfdoc, string filename, string stringparam, int intparam )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$filename}, \${3:\$stringparam}, \${4:\$intparam} )", 
	"desc" => "Opens a PDF file", 
	"docurl" => "function.pdf-open-pdi.html" 
),
"pdf_place_image" => array( 
	"methodname" => "pdf_place_image", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool pdf_place_image ( resource pdfdoc, int image, float x, float y, float scale )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$image}, \${3:\$x}, \${4:\$y}, \${5:\$scale} )", 
	"desc" => "Places an image on the page", 
	"docurl" => "function.pdf-place-image.html" 
),
"pdf_place_pdi_page" => array( 
	"methodname" => "pdf_place_pdi_page", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool pdf_place_pdi_page ( resource pdfdoc, int page, float x, float y, float sx, float sy )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$page}, \${3:\$x}, \${4:\$y}, \${5:\$sx}, \${6:\$sy} )", 
	"desc" => "Places an image on the page", 
	"docurl" => "function.pdf-place-pdi-page.html" 
),
"pdf_rect" => array( 
	"methodname" => "pdf_rect", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_rect ( resource pdfdoc, float x, float y, float width, float height )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y}, \${4:\$width}, \${5:\$height} )", 
	"desc" => "Draws a rectangle", 
	"docurl" => "function.pdf-rect.html" 
),
"pdf_restore" => array( 
	"methodname" => "pdf_restore", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_restore ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Restores formerly saved environment", 
	"docurl" => "function.pdf-restore.html" 
),
"pdf_rotate" => array( 
	"methodname" => "pdf_rotate", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_rotate ( resource pdfdoc, float phi )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$phi} )", 
	"desc" => "Sets rotation", 
	"docurl" => "function.pdf-rotate.html" 
),
"pdf_save" => array( 
	"methodname" => "pdf_save", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_save ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Saves the current environment", 
	"docurl" => "function.pdf-save.html" 
),
"pdf_scale" => array( 
	"methodname" => "pdf_scale", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_scale ( resource pdfdoc, float x_scale, float y_scale )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x_scale}, \${3:\$y_scale} )", 
	"desc" => "Sets scaling", 
	"docurl" => "function.pdf-scale.html" 
),
"pdf_set_border_color" => array( 
	"methodname" => "pdf_set_border_color", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool pdf_set_border_color ( resource pdfdoc, float red, float green, float blue )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Sets color of border around links and annotations", 
	"docurl" => "function.pdf-set-border-color.html" 
),
"pdf_set_border_dash" => array( 
	"methodname" => "pdf_set_border_dash", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool pdf_set_border_dash ( resource pdfdoc, float black, float white )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$black}, \${3:\$white} )", 
	"desc" => "Sets dash style of border around links and annotations", 
	"docurl" => "function.pdf-set-border-dash.html" 
),
"pdf_set_border_style" => array( 
	"methodname" => "pdf_set_border_style", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool pdf_set_border_style ( resource pdfdoc, string style, float width )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$style}, \${3:\$width} )", 
	"desc" => "Sets style of border around links and annotations", 
	"docurl" => "function.pdf-set-border-style.html" 
),
"pdf_set_info" => array( 
	"methodname" => "pdf_set_info", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool pdf_set_info ( resource pdfdoc, string key, string value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$value} )", 
	"desc" => "Fills a field of the document information", 
	"docurl" => "function.pdf-set-info.html" 
),
"pdf_set_parameter" => array( 
	"methodname" => "pdf_set_parameter", 
	"version" => "PHP4, PHP5", 
	"method" => "bool pdf_set_parameter ( resource pdfdoc, string key, string value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$value} )", 
	"desc" => "Sets certain parameters", 
	"docurl" => "function.pdf-set-parameter.html" 
),
"pdf_set_text_pos" => array( 
	"methodname" => "pdf_set_text_pos", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_set_text_pos ( resource pdfdoc, float x, float y )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$x}, \${3:\$y} )", 
	"desc" => "Sets text position", 
	"docurl" => "function.pdf-set-text-pos.html" 
),
"pdf_set_value" => array( 
	"methodname" => "pdf_set_value", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool pdf_set_value ( resource pdfdoc, string key, float value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$key}, \${3:\$value} )", 
	"desc" => "Sets certain numerical value", 
	"docurl" => "function.pdf-set-value.html" 
),
"pdf_setcolor" => array( 
	"methodname" => "pdf_setcolor", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_setcolor ( resource pdfdoc, string type, string colorspace, float c1, float c2, float c3, float c4 )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$type}, \${3:\$colorspace}, \${4:\$c1}, \${5:\$c2}, \${6:\$c3}, \${7:\$c4} )", 
	"desc" => "Sets fill and stroke color", 
	"docurl" => "function.pdf-setcolor.html" 
),
"pdf_setdash" => array( 
	"methodname" => "pdf_setdash", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setdash ( resource pdfdoc, float b, float w )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$b}, \${3:\$w} )", 
	"desc" => "Sets dash pattern", 
	"docurl" => "function.pdf-setdash.html" 
),
"pdf_setflat" => array( 
	"methodname" => "pdf_setflat", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setflat ( resource pdfdoc, float flatness )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$flatness} )", 
	"desc" => "Sets flatness", 
	"docurl" => "function.pdf-setflat.html" 
),
"pdf_setfont" => array( 
	"methodname" => "pdf_setfont", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_setfont ( resource pdfdoc, int font, float size )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$font}, \${3:\$size} )", 
	"desc" => "Set the current font", 
	"docurl" => "function.pdf-setfont.html" 
),
"pdf_setgray_fill" => array( 
	"methodname" => "pdf_setgray_fill", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setgray_fill ( resource pdfdoc, float gray )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$gray} )", 
	"desc" => "Sets filling color to gray value", 
	"docurl" => "function.pdf-setgray-fill.html" 
),
"pdf_setgray_stroke" => array( 
	"methodname" => "pdf_setgray_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setgray_stroke ( resource pdfdoc, float gray )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$gray} )", 
	"desc" => "Sets drawing color to gray value", 
	"docurl" => "function.pdf-setgray-stroke.html" 
),
"pdf_setgray" => array( 
	"methodname" => "pdf_setgray", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setgray ( resource pdfdoc, float gray )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$gray} )", 
	"desc" => "Sets drawing and filling color to gray value", 
	"docurl" => "function.pdf-setgray.html" 
),
"pdf_setlinecap" => array( 
	"methodname" => "pdf_setlinecap", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "void pdf_setlinecap ( resource pdfdoc, int linecap )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$linecap} )", 
	"desc" => "Sets linecap parameter", 
	"docurl" => "function.pdf-setlinecap.html" 
),
"pdf_setlinejoin" => array( 
	"methodname" => "pdf_setlinejoin", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setlinejoin ( resource pdfdoc, int value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$value} )", 
	"desc" => "Sets linejoin parameter", 
	"docurl" => "function.pdf-setlinejoin.html" 
),
"pdf_setlinewidth" => array( 
	"methodname" => "pdf_setlinewidth", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "void pdf_setlinewidth ( resource pdfdoc, float width )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$width} )", 
	"desc" => "Sets line width", 
	"docurl" => "function.pdf-setlinewidth.html" 
),
"pdf_setmatrix" => array( 
	"methodname" => "pdf_setmatrix", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool pdf_setmatrix ( resource pdfdoc, float a, float b, float c, float d, float e, float f )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$a}, \${3:\$b}, \${4:\$c}, \${5:\$d}, \${6:\$e}, \${7:\$f} )", 
	"desc" => "Sets current transformation matrix", 
	"docurl" => "function.pdf-setmatrix.html" 
),
"pdf_setmiterlimit" => array( 
	"methodname" => "pdf_setmiterlimit", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setmiterlimit ( resource pdfdoc, float miter )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$miter} )", 
	"desc" => "Sets miter limit", 
	"docurl" => "function.pdf-setmiterlimit.html" 
),
"pdf_setrgbcolor_fill" => array( 
	"methodname" => "pdf_setrgbcolor_fill", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setrgbcolor_fill ( resource pdfdoc, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets filling color to rgb color value", 
	"docurl" => "function.pdf-setrgbcolor-fill.html" 
),
"pdf_setrgbcolor_stroke" => array( 
	"methodname" => "pdf_setrgbcolor_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setrgbcolor_stroke ( resource pdfdoc, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets drawing color to rgb color value", 
	"docurl" => "function.pdf-setrgbcolor-stroke.html" 
),
"pdf_setrgbcolor" => array( 
	"methodname" => "pdf_setrgbcolor", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_setrgbcolor ( resource pdfdoc, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets drawing and filling color to rgb color value", 
	"docurl" => "function.pdf-setrgbcolor.html" 
),
"pdf_show_boxed" => array( 
	"methodname" => "pdf_show_boxed", 
	"version" => "PHP4, PHP5", 
	"method" => "int pdf_show_boxed ( resource pdfdoc, string text, float left, float top, float width, float height, string mode, string feature )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text}, \${3:\$left}, \${4:\$top}, \${5:\$width}, \${6:\$height}, \${7:\$mode}, \${8:\$feature} )", 
	"desc" => "Output text in a box", 
	"docurl" => "function.pdf-show-boxed.html" 
),
"pdf_show_xy" => array( 
	"methodname" => "pdf_show_xy", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_show_xy ( resource pdfdoc, string text, float x, float y )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text}, \${3:\$x}, \${4:\$y} )", 
	"desc" => "Output text at given position", 
	"docurl" => "function.pdf-show-xy.html" 
),
"pdf_show" => array( 
	"methodname" => "pdf_show", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_show ( resource pdfdoc, string text )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text} )", 
	"desc" => "Output text at current position", 
	"docurl" => "function.pdf-show.html" 
),
"pdf_skew" => array( 
	"methodname" => "pdf_skew", 
	"version" => "PHP4, PHP5", 
	"method" => "bool pdf_skew ( resource pdfdoc, float alpha, float beta )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$alpha}, \${3:\$beta} )", 
	"desc" => "Skews the coordinate system", 
	"docurl" => "function.pdf-skew.html" 
),
"pdf_stringwidth" => array( 
	"methodname" => "pdf_stringwidth", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "float pdf_stringwidth ( resource pdfdoc, string text, int font, float size )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$text}, \${3:\$font}, \${4:\$size} )", 
	"desc" => "Returns width of text using current font", 
	"docurl" => "function.pdf-stringwidth.html" 
),
"pdf_stroke" => array( 
	"methodname" => "pdf_stroke", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_stroke ( resource pdfdoc )", 
	"snippet" => "( \${1:\$pdfdoc} )", 
	"desc" => "Draws line along path", 
	"docurl" => "function.pdf-stroke.html" 
),
"pdf_translate" => array( 
	"methodname" => "pdf_translate", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool pdf_translate ( resource pdfdoc, float tx, float ty )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$tx}, \${3:\$ty} )", 
	"desc" => "Sets origin of coordinate system", 
	"docurl" => "function.pdf-translate.html" 
),
"pfpro_cleanup" => array( 
	"methodname" => "pfpro_cleanup", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "void pfpro_cleanup ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Shuts down the Payflow Pro library", 
	"docurl" => "function.pfpro-cleanup.html" 
),
"pfpro_init" => array( 
	"methodname" => "pfpro_init", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "void pfpro_init ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initialises the Payflow Pro library", 
	"docurl" => "function.pfpro-init.html" 
),
"pfpro_process_raw" => array( 
	"methodname" => "pfpro_process_raw", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string pfpro_process_raw ( string parameters [, string address [, int port [, int timeout [, string proxy_address [, int proxy_port [, string proxy_logon [, string proxy_password]]]]]]] )", 
	"snippet" => "( \${1:\$parameters} )", 
	"desc" => "Process a raw transaction with Payflow Pro", 
	"docurl" => "function.pfpro-process-raw.html" 
),
"pfpro_process" => array( 
	"methodname" => "pfpro_process", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array pfpro_process ( array parameters [, string address [, int port [, int timeout [, string proxy_address [, int proxy_port [, string proxy_logon [, string proxy_password]]]]]]] )", 
	"snippet" => "( \${1:\$parameters} )", 
	"desc" => "Process a transaction with Payflow Pro", 
	"docurl" => "function.pfpro-process.html" 
),
"pfpro_version" => array( 
	"methodname" => "pfpro_version", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string pfpro_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the version of the Payflow Pro software", 
	"docurl" => "function.pfpro-version.html" 
),
"pfsockopen" => array( 
	"methodname" => "pfsockopen", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "resource pfsockopen ( string hostname, int port [, int &errno [, string &errstr [, int timeout]]] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$port} )", 
	"desc" => "Open persistent Internet or Unix domain socket connection", 
	"docurl" => "function.pfsockopen.html" 
),
"pg_affected_rows" => array( 
	"methodname" => "pg_affected_rows", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_affected_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns number of affected records (tuples)", 
	"docurl" => "function.pg-affected-rows.html" 
),
"pg_cancel_query" => array( 
	"methodname" => "pg_cancel_query", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_cancel_query ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Cancel asynchronous query", 
	"docurl" => "function.pg-cancel-query.html" 
),
"pg_client_encoding" => array( 
	"methodname" => "pg_client_encoding", 
	"version" => "PHP3 CVS only, PHP4 >= 4.0.3, PHP5", 
	"method" => "string pg_client_encoding ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets the client encoding", 
	"docurl" => "function.pg-client-encoding.html" 
),
"pg_close" => array( 
	"methodname" => "pg_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool pg_close ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Closes a PostgreSQL connection", 
	"docurl" => "function.pg-close.html" 
),
"pg_connect" => array( 
	"methodname" => "pg_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource pg_connect ( string connection_string [, int connect_type] )", 
	"snippet" => "( \${1:\$connection_string} )", 
	"desc" => "Open a PostgreSQL connection", 
	"docurl" => "function.pg-connect.html" 
),
"pg_connection_busy" => array( 
	"methodname" => "pg_connection_busy", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_connection_busy ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Get connection is busy or not", 
	"docurl" => "function.pg-connection-busy.html" 
),
"pg_connection_reset" => array( 
	"methodname" => "pg_connection_reset", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_connection_reset ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Reset connection (reconnect)", 
	"docurl" => "function.pg-connection-reset.html" 
),
"pg_connection_status" => array( 
	"methodname" => "pg_connection_status", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_connection_status ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Get connection status", 
	"docurl" => "function.pg-connection-status.html" 
),
"pg_convert" => array( 
	"methodname" => "pg_convert", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_convert ( resource connection, string table_name, array assoc_array [, int options] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$assoc_array} )", 
	"desc" => "Convert associative array value into suitable for SQL statement", 
	"docurl" => "function.pg-convert.html" 
),
"pg_copy_from" => array( 
	"methodname" => "pg_copy_from", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_copy_from ( resource connection, string table_name, array rows [, string delimiter [, string null_as]] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$rows} )", 
	"desc" => "Insert records into a table from an array", 
	"docurl" => "function.pg-copy-from.html" 
),
"pg_copy_to" => array( 
	"methodname" => "pg_copy_to", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array pg_copy_to ( resource connection, string table_name [, string delimiter [, string null_as]] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name} )", 
	"desc" => "Copy a table to an array", 
	"docurl" => "function.pg-copy-to.html" 
),
"pg_dbname" => array( 
	"methodname" => "pg_dbname", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string pg_dbname ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Get the database name", 
	"docurl" => "function.pg-dbname.html" 
),
"pg_delete" => array( 
	"methodname" => "pg_delete", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "mixed pg_delete ( resource connection, string table_name, array assoc_array [, int options] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$assoc_array} )", 
	"desc" => "Deletes records", 
	"docurl" => "function.pg-delete.html" 
),
"pg_end_copy" => array( 
	"methodname" => "pg_end_copy", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool pg_end_copy ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Sync with PostgreSQL backend", 
	"docurl" => "function.pg-end-copy.html" 
),
"pg_escape_bytea" => array( 
	"methodname" => "pg_escape_bytea", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_escape_bytea ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Escape binary for bytea type", 
	"docurl" => "function.pg-escape-bytea.html" 
),
"pg_escape_string" => array( 
	"methodname" => "pg_escape_string", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_escape_string ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Escape string for text/char type", 
	"docurl" => "function.pg-escape-string.html" 
),
"pg_execute" => array( 
	"methodname" => "pg_execute", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "resource pg_execute ( string stmtname, array params )", 
	"snippet" => "( \${1:\$stmtname}, \${2:\$params} )", 
	"desc" => "Execute a previously prepared query", 
	"docurl" => "function.pg-execute.html" 
),
"pg_fetch_all" => array( 
	"methodname" => "pg_fetch_all", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_fetch_all ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches all rows from a result as an array", 
	"docurl" => "function.pg-fetch-all.html" 
),
"pg_fetch_array" => array( 
	"methodname" => "pg_fetch_array", 
	"version" => "PHP3>= 3.0.1, PHP4, PHP5", 
	"method" => "array pg_fetch_array ( resource result [, int row [, int result_type]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a row as an array", 
	"docurl" => "function.pg-fetch-array.html" 
),
"pg_fetch_assoc" => array( 
	"methodname" => "pg_fetch_assoc", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_fetch_assoc ( resource result [, int row] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a row as an associative array", 
	"docurl" => "function.pg-fetch-assoc.html" 
),
"pg_fetch_object" => array( 
	"methodname" => "pg_fetch_object", 
	"version" => "PHP3>= 3.0.1, PHP4, PHP5", 
	"method" => "object pg_fetch_object ( resource result [, int row [, int result_type]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a row as an object", 
	"docurl" => "function.pg-fetch-object.html" 
),
"pg_fetch_result" => array( 
	"methodname" => "pg_fetch_result", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "mixed pg_fetch_result ( resource result, int row, mixed field )", 
	"snippet" => "( \${1:\$result}, \${2:\$row}, \${3:\$field} )", 
	"desc" => "Returns values from a result resource", 
	"docurl" => "function.pg-fetch-result.html" 
),
"pg_fetch_row" => array( 
	"methodname" => "pg_fetch_row", 
	"version" => "PHP3>= 3.0.1, PHP4, PHP5", 
	"method" => "array pg_fetch_row ( resource result [, int row] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get a row as an enumerated array", 
	"docurl" => "function.pg-fetch-row.html" 
),
"pg_field_is_null" => array( 
	"methodname" => "pg_field_is_null", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_field_is_null ( resource result, int row, mixed field )", 
	"snippet" => "( \${1:\$result}, \${2:\$row}, \${3:\$field} )", 
	"desc" => "Test if a field is NULL", 
	"docurl" => "function.pg-field-is-null.html" 
),
"pg_field_name" => array( 
	"methodname" => "pg_field_name", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_field_name ( resource result, int field_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_number} )", 
	"desc" => "Returns the name of a field", 
	"docurl" => "function.pg-field-name.html" 
),
"pg_field_num" => array( 
	"methodname" => "pg_field_num", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_field_num ( resource result, string field_name )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_name} )", 
	"desc" => "Returns the field number of the named field", 
	"docurl" => "function.pg-field-num.html" 
),
"pg_field_prtlen" => array( 
	"methodname" => "pg_field_prtlen", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_field_prtlen ( resource result [, int row_number, mixed field_name_or_number] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the printed length", 
	"docurl" => "function.pg-field-prtlen.html" 
),
"pg_field_size" => array( 
	"methodname" => "pg_field_size", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_field_size ( resource result, int field_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_number} )", 
	"desc" => "Returns the internal storage size of the named field", 
	"docurl" => "function.pg-field-size.html" 
),
"pg_field_type_oid" => array( 
	"methodname" => "pg_field_type_oid", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "int pg_field_type_oid ( resource result, int field_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_number} )", 
	"desc" => "Returns the type ID (OID) for the corresponding field number", 
	"docurl" => "function.pg-field-type-oid.html" 
),
"pg_field_type" => array( 
	"methodname" => "pg_field_type", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_field_type ( resource result, int field_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_number} )", 
	"desc" => "Returns the type name for the corresponding field number", 
	"docurl" => "function.pg-field-type.html" 
),
"pg_free_result" => array( 
	"methodname" => "pg_free_result", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.pg-free-result.html" 
),
"pg_get_notify" => array( 
	"methodname" => "pg_get_notify", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_get_notify ( resource connection [, int result_type] )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Ping database connection", 
	"docurl" => "function.pg-get-notify.html" 
),
"pg_get_pid" => array( 
	"methodname" => "pg_get_pid", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int pg_get_pid ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Ping database connection", 
	"docurl" => "function.pg-get-pid.html" 
),
"pg_get_result" => array( 
	"methodname" => "pg_get_result", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource pg_get_result ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get asynchronous query result", 
	"docurl" => "function.pg-get-result.html" 
),
"pg_host" => array( 
	"methodname" => "pg_host", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string pg_host ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Returns the host name associated with the connection", 
	"docurl" => "function.pg-host.html" 
),
"pg_insert" => array( 
	"methodname" => "pg_insert", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool pg_insert ( resource connection, string table_name, array assoc_array [, int options] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$assoc_array} )", 
	"desc" => "Insert array into table", 
	"docurl" => "function.pg-insert.html" 
),
"pg_last_error" => array( 
	"methodname" => "pg_last_error", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_last_error ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the last error message string of a connection", 
	"docurl" => "function.pg-last-error.html" 
),
"pg_last_notice" => array( 
	"methodname" => "pg_last_notice", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string pg_last_notice ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Returns the last notice message from PostgreSQL server", 
	"docurl" => "function.pg-last-notice.html" 
),
"pg_last_oid" => array( 
	"methodname" => "pg_last_oid", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_last_oid ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the last object\'s oid", 
	"docurl" => "function.pg-last-oid.html" 
),
"pg_lo_close" => array( 
	"methodname" => "pg_lo_close", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_lo_close ( resource large_object )", 
	"snippet" => "( \${1:\$large_object} )", 
	"desc" => "Close a large object", 
	"docurl" => "function.pg-lo-close.html" 
),
"pg_lo_create" => array( 
	"methodname" => "pg_lo_create", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_lo_create ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create a large object", 
	"docurl" => "function.pg-lo-create.html" 
),
"pg_lo_export" => array( 
	"methodname" => "pg_lo_export", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_lo_export ( [resource connection, int oid, string pathname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Export a large object to file", 
	"docurl" => "function.pg-lo-export.html" 
),
"pg_lo_import" => array( 
	"methodname" => "pg_lo_import", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_lo_import ( [resource connection, string pathname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Import a large object from file", 
	"docurl" => "function.pg-lo-import.html" 
),
"pg_lo_open" => array( 
	"methodname" => "pg_lo_open", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource pg_lo_open ( resource connection, int oid, string mode )", 
	"snippet" => "( \${1:\$connection}, \${2:\$oid}, \${3:\$mode} )", 
	"desc" => "Open a large object", 
	"docurl" => "function.pg-lo-open.html" 
),
"pg_lo_read_all" => array( 
	"methodname" => "pg_lo_read_all", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_lo_read_all ( resource large_object )", 
	"snippet" => "( \${1:\$large_object} )", 
	"desc" => "Reads an entire large object and send straight to browser", 
	"docurl" => "function.pg-lo-read-all.html" 
),
"pg_lo_read" => array( 
	"methodname" => "pg_lo_read", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_lo_read ( resource large_object [, int len] )", 
	"snippet" => "( \${1:\$large_object} )", 
	"desc" => "Read a large object", 
	"docurl" => "function.pg-lo-read.html" 
),
"pg_lo_seek" => array( 
	"methodname" => "pg_lo_seek", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_lo_seek ( resource large_object, int offset [, int whence] )", 
	"snippet" => "( \${1:\$large_object}, \${2:\$offset} )", 
	"desc" => "Seeks position of large object", 
	"docurl" => "function.pg-lo-seek.html" 
),
"pg_lo_tell" => array( 
	"methodname" => "pg_lo_tell", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_lo_tell ( resource large_object )", 
	"snippet" => "( \${1:\$large_object} )", 
	"desc" => "Returns current position of large object", 
	"docurl" => "function.pg-lo-tell.html" 
),
"pg_lo_unlink" => array( 
	"methodname" => "pg_lo_unlink", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_lo_unlink ( resource connection, int oid )", 
	"snippet" => "( \${1:\$connection}, \${2:\$oid} )", 
	"desc" => "Delete a large object", 
	"docurl" => "function.pg-lo-unlink.html" 
),
"pg_lo_write" => array( 
	"methodname" => "pg_lo_write", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_lo_write ( resource large_object, string data [, int len] )", 
	"snippet" => "( \${1:\$large_object}, \${2:\$data} )", 
	"desc" => "Write a large object", 
	"docurl" => "function.pg-lo-write.html" 
),
"pg_meta_data" => array( 
	"methodname" => "pg_meta_data", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_meta_data ( resource connection, string table_name )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name} )", 
	"desc" => "Get meta data for table", 
	"docurl" => "function.pg-meta-data.html" 
),
"pg_num_fields" => array( 
	"methodname" => "pg_num_fields", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the number of fields", 
	"docurl" => "function.pg-num-fields.html" 
),
"pg_num_rows" => array( 
	"methodname" => "pg_num_rows", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int pg_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the number of rows", 
	"docurl" => "function.pg-num-rows.html" 
),
"pg_options" => array( 
	"methodname" => "pg_options", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string pg_options ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Get the options associated with the connection", 
	"docurl" => "function.pg-options.html" 
),
"pg_parameter_status" => array( 
	"methodname" => "pg_parameter_status", 
	"version" => "PHP5", 
	"method" => "string pg_parameter_status ( [resource connection, string param_name] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the value of a server parameter", 
	"docurl" => "function.pg-parameter-status.html" 
),
"pg_pconnect" => array( 
	"methodname" => "pg_pconnect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource pg_pconnect ( string connection_string [, int connect_type] )", 
	"snippet" => "( \${1:\$connection_string} )", 
	"desc" => "Open a persistent PostgreSQL connection", 
	"docurl" => "function.pg-pconnect.html" 
),
"pg_ping" => array( 
	"methodname" => "pg_ping", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool pg_ping ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Ping database connection", 
	"docurl" => "function.pg-ping.html" 
),
"pg_port" => array( 
	"methodname" => "pg_port", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int pg_port ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Return the port number associated with the connection", 
	"docurl" => "function.pg-port.html" 
),
"pg_prepare" => array( 
	"methodname" => "pg_prepare", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "resource pg_prepare ( string stmtname, string query )", 
	"snippet" => "( \${1:\$stmtname}, \${2:\$query} )", 
	"desc" => "Prepares a query for future execution", 
	"docurl" => "function.pg-prepare.html" 
),
"pg_put_line" => array( 
	"methodname" => "pg_put_line", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool pg_put_line ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Send a NULL-terminated string to PostgreSQL backend", 
	"docurl" => "function.pg-put-line.html" 
),
"pg_query_params" => array( 
	"methodname" => "pg_query_params", 
	"version" => "undefined", 
	"method" => "resource pg_query_params ( string query, array params )", 
	"snippet" => "( \${1:\$query}, \${2:\$params} )", 
	"desc" => "Execute a query, specifying query variables as separate parameters", 
	"docurl" => "function.pg-query-params.html" 
),
"pg_query" => array( 
	"methodname" => "pg_query", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource pg_query ( string query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Execute a query", 
	"docurl" => "function.pg-query.html" 
),
"pg_result_error_field" => array( 
	"methodname" => "pg_result_error_field", 
	"version" => "undefined", 
	"method" => "string pg_result_error_field ( resource result, int fieldcode )", 
	"snippet" => "( \${1:\$result}, \${2:\$fieldcode} )", 
	"desc" => "Get error message field associated with result", 
	"docurl" => "function.pg-result-error-field.html" 
),
"pg_result_error" => array( 
	"methodname" => "pg_result_error", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string pg_result_error ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get error message associated with result", 
	"docurl" => "function.pg-result-error.html" 
),
"pg_result_seek" => array( 
	"methodname" => "pg_result_seek", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_result_seek ( resource result, int offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$offset} )", 
	"desc" => "Set internal row offset in result resource", 
	"docurl" => "function.pg-result-seek.html" 
),
"pg_result_status" => array( 
	"methodname" => "pg_result_status", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "mixed pg_result_status ( resource result [, int type] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get status of query result", 
	"docurl" => "function.pg-result-status.html" 
),
"pg_select" => array( 
	"methodname" => "pg_select", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array pg_select ( resource connection, string table_name, array assoc_array [, int options] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$assoc_array} )", 
	"desc" => "Select records", 
	"docurl" => "function.pg-select.html" 
),
"pg_send_execute" => array( 
	"methodname" => "pg_send_execute", 
	"version" => "undefined", 
	"method" => "resource pg_send_execute ( string stmtname, array params )", 
	"snippet" => "( \${1:\$stmtname}, \${2:\$params} )", 
	"desc" => "Asynchronously execute a previously prepared query", 
	"docurl" => "function.pg-send-execute.html" 
),
"pg_send_prepare" => array( 
	"methodname" => "pg_send_prepare", 
	"version" => "undefined", 
	"method" => "resource pg_send_prepare ( string stmtname, string query )", 
	"snippet" => "( \${1:\$stmtname}, \${2:\$query} )", 
	"desc" => "Asynchronously prepares a query for future execution", 
	"docurl" => "function.pg-send-prepare.html" 
),
"pg_send_query_params" => array( 
	"methodname" => "pg_send_query_params", 
	"version" => "undefined", 
	"method" => "bool pg_send_query_params ( resource connection, string query, array params )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query}, \${3:\$params} )", 
	"desc" => "Sends asynchronous query, specifying query variables as separate parameters", 
	"docurl" => "function.pg-send-query-params.html" 
),
"pg_send_query" => array( 
	"methodname" => "pg_send_query", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool pg_send_query ( resource connection, string query )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query} )", 
	"desc" => "Sends asynchronous query", 
	"docurl" => "function.pg-send-query.html" 
),
"pg_set_client_encoding" => array( 
	"methodname" => "pg_set_client_encoding", 
	"version" => "PHP3 CVS only, PHP4 >= 4.0.3, PHP5", 
	"method" => "int pg_set_client_encoding ( string encoding )", 
	"snippet" => "( \${1:\$encoding} )", 
	"desc" => "Set the client encoding", 
	"docurl" => "function.pg-set-client-encoding.html" 
),
"pg_set_error_verbosity" => array( 
	"methodname" => "pg_set_error_verbosity", 
	"version" => "undefined", 
	"method" => "int pg_set_error_verbosity ( int verbosity )", 
	"snippet" => "( \${1:\$verbosity} )", 
	"desc" => "", 
	"docurl" => "function.pg-set-error-verbosity.html" 
),
"pg_trace" => array( 
	"methodname" => "pg_trace", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool pg_trace ( string pathname [, string mode [, resource connection]] )", 
	"snippet" => "( \${1:\$pathname} )", 
	"desc" => "Enable tracing a PostgreSQL connection", 
	"docurl" => "function.pg-trace.html" 
),
"pg_tty" => array( 
	"methodname" => "pg_tty", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string pg_tty ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Return the tty name associated with the connection", 
	"docurl" => "function.pg-tty.html" 
),
"pg_unescape_bytea" => array( 
	"methodname" => "pg_unescape_bytea", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string pg_unescape_bytea ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Unescape binary for bytea type", 
	"docurl" => "function.pg-unescape-bytea.html" 
),
"pg_untrace" => array( 
	"methodname" => "pg_untrace", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool pg_untrace ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Disable tracing of a PostgreSQL connection", 
	"docurl" => "function.pg-untrace.html" 
),
"pg_update" => array( 
	"methodname" => "pg_update", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "mixed pg_update ( resource connection, string table_name, array data, array condition [, int options] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$table_name}, \${3:\$data}, \${4:\$condition} )", 
	"desc" => "Update table", 
	"docurl" => "function.pg-update.html" 
),
"pg_version" => array( 
	"methodname" => "pg_version", 
	"version" => "PHP5", 
	"method" => "array pg_version ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns an array with client, protocol and server version (when available)", 
	"docurl" => "function.pg-version.html" 
),
"pg_transaction_status" => array( 
	"methodname" => "pg_transaction_status", 
	"version" => "undefined", 
	"method" => "int pg_transaction_status ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "", 
	"docurl" => "function.pg_transaction_status.html" 
),
"php_check_syntax" => array( 
	"methodname" => "php_check_syntax", 
	"version" => "PHP5", 
	"method" => "bool php_check_syntax ( string file_name [, string &error_message] )", 
	"snippet" => "( \${1:\$file_name} )", 
	"desc" => "Check the PHP syntax of (and execute) the specified file", 
	"docurl" => "function.php-check-syntax.html" 
),
"php_ini_scanned_files" => array( 
	"methodname" => "php_ini_scanned_files", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string php_ini_scanned_files ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return a list of .ini files parsed from the additional ini dir", 
	"docurl" => "function.php-ini-scanned-files.html" 
),
"php_logo_guid" => array( 
	"methodname" => "php_logo_guid", 
	"version" => "PHP4, PHP5", 
	"method" => "string php_logo_guid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the logo guid", 
	"docurl" => "function.php-logo-guid.html" 
),
"php_sapi_name" => array( 
	"methodname" => "php_sapi_name", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string php_sapi_name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the type of interface between web server and PHP", 
	"docurl" => "function.php-sapi-name.html" 
),
"php_strip_whitespace" => array( 
	"methodname" => "php_strip_whitespace", 
	"version" => "PHP5", 
	"method" => "string php_strip_whitespace ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Return source with stripped comments and whitespace", 
	"docurl" => "function.php-strip-whitespace.html" 
),
"php_uname" => array( 
	"methodname" => "php_uname", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string php_uname ( [string mode] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns information about the operating system PHP is running on", 
	"docurl" => "function.php-uname.html" 
),
"phpcredits" => array( 
	"methodname" => "phpcredits", 
	"version" => "PHP4, PHP5", 
	"method" => "void phpcredits ( [int flag] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Prints out the credits for PHP", 
	"docurl" => "function.phpcredits.html" 
),
"phpinfo" => array( 
	"methodname" => "phpinfo", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int phpinfo ( [int what] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Outputs lots of PHP information", 
	"docurl" => "function.phpinfo.html" 
),
"phpversion" => array( 
	"methodname" => "phpversion", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string phpversion ( [string extension] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets the current PHP version", 
	"docurl" => "function.phpversion.html" 
),
"pi" => array( 
	"methodname" => "pi", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float pi ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get value of pi", 
	"docurl" => "function.pi.html" 
),
"png2wbmp" => array( 
	"methodname" => "png2wbmp", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int png2wbmp ( string pngname, string wbmpname, int d_height, int d_width, int threshold )", 
	"snippet" => "( \${1:\$pngname}, \${2:\$wbmpname}, \${3:\$d_height}, \${4:\$d_width}, \${5:\$threshold} )", 
	"desc" => "Convert PNG image file to WBMP image file", 
	"docurl" => "function.png2wbmp.html" 
),
"popen" => array( 
	"methodname" => "popen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource popen ( string command, string mode )", 
	"snippet" => "( \${1:\$command}, \${2:\$mode} )", 
	"desc" => "Opens process file pointer", 
	"docurl" => "function.popen.html" 
),
"pos" => array( 
	"methodname" => "pos", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed pos ( array &array )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of current()\nReturn the current element in an array", 
	"docurl" => "function.pos.html" 
),
"posix_access" => array( 
	"methodname" => "posix_access", 
	"version" => "undefined", 
	"method" => "bool posix_access ( string file [, int mode] )", 
	"snippet" => "( \${1:\$file} )", 
	"desc" => "Determine accessibility of a files", 
	"docurl" => "function.posix-access.html" 
),
"posix_ctermid" => array( 
	"methodname" => "posix_ctermid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string posix_ctermid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get path name of controlling terminal", 
	"docurl" => "function.posix-ctermid.html" 
),
"posix_get_last_error" => array( 
	"methodname" => "posix_get_last_error", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int posix_get_last_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve the error number set by the last posix function   that failed", 
	"docurl" => "function.posix-get-last-error.html" 
),
"posix_getcwd" => array( 
	"methodname" => "posix_getcwd", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string posix_getcwd ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Pathname of current directory", 
	"docurl" => "function.posix-getcwd.html" 
),
"posix_getegid" => array( 
	"methodname" => "posix_getegid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getegid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the effective group ID of the current process", 
	"docurl" => "function.posix-getegid.html" 
),
"posix_geteuid" => array( 
	"methodname" => "posix_geteuid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_geteuid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the effective user ID of the current process", 
	"docurl" => "function.posix-geteuid.html" 
),
"posix_getgid" => array( 
	"methodname" => "posix_getgid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getgid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the real group ID of the current process", 
	"docurl" => "function.posix-getgid.html" 
),
"posix_getgrgid" => array( 
	"methodname" => "posix_getgrgid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array posix_getgrgid ( int gid )", 
	"snippet" => "( \${1:\$gid} )", 
	"desc" => "Return info about a group by group id", 
	"docurl" => "function.posix-getgrgid.html" 
),
"posix_getgrnam" => array( 
	"methodname" => "posix_getgrnam", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array posix_getgrnam ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Return info about a group by name", 
	"docurl" => "function.posix-getgrnam.html" 
),
"posix_getgroups" => array( 
	"methodname" => "posix_getgroups", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "array posix_getgroups ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the group set of the current process", 
	"docurl" => "function.posix-getgroups.html" 
),
"posix_getlogin" => array( 
	"methodname" => "posix_getlogin", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string posix_getlogin ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return login name", 
	"docurl" => "function.posix-getlogin.html" 
),
"posix_getpgid" => array( 
	"methodname" => "posix_getpgid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getpgid ( int pid )", 
	"snippet" => "( \${1:\$pid} )", 
	"desc" => "Get process group id for job control", 
	"docurl" => "function.posix-getpgid.html" 
),
"posix_getpgrp" => array( 
	"methodname" => "posix_getpgrp", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getpgrp ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the current process group identifier", 
	"docurl" => "function.posix-getpgrp.html" 
),
"posix_getpid" => array( 
	"methodname" => "posix_getpid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getpid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the current process identifier", 
	"docurl" => "function.posix-getpid.html" 
),
"posix_getppid" => array( 
	"methodname" => "posix_getppid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getppid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the parent process identifier", 
	"docurl" => "function.posix-getppid.html" 
),
"posix_getpwnam" => array( 
	"methodname" => "posix_getpwnam", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array posix_getpwnam ( string username )", 
	"snippet" => "( \${1:\$username} )", 
	"desc" => "Return info about a user by username", 
	"docurl" => "function.posix-getpwnam.html" 
),
"posix_getpwuid" => array( 
	"methodname" => "posix_getpwuid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array posix_getpwuid ( int uid )", 
	"snippet" => "( \${1:\$uid} )", 
	"desc" => "Return info about a user by user id", 
	"docurl" => "function.posix-getpwuid.html" 
),
"posix_getrlimit" => array( 
	"methodname" => "posix_getrlimit", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "array posix_getrlimit ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return info about system resource limits", 
	"docurl" => "function.posix-getrlimit.html" 
),
"posix_getsid" => array( 
	"methodname" => "posix_getsid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getsid ( int pid )", 
	"snippet" => "( \${1:\$pid} )", 
	"desc" => "Get the current sid of the process", 
	"docurl" => "function.posix-getsid.html" 
),
"posix_getuid" => array( 
	"methodname" => "posix_getuid", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "int posix_getuid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the real user ID of the current process", 
	"docurl" => "function.posix-getuid.html" 
),
"posix_isatty" => array( 
	"methodname" => "posix_isatty", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool posix_isatty ( int fd )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Determine if a file descriptor is an interactive terminal", 
	"docurl" => "function.posix-isatty.html" 
),
"posix_kill" => array( 
	"methodname" => "posix_kill", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool posix_kill ( int pid, int sig )", 
	"snippet" => "( \${1:\$pid}, \${2:\$sig} )", 
	"desc" => "Send a signal to a process", 
	"docurl" => "function.posix-kill.html" 
),
"posix_mkfifo" => array( 
	"methodname" => "posix_mkfifo", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool posix_mkfifo ( string pathname, int mode )", 
	"snippet" => "( \${1:\$pathname}, \${2:\$mode} )", 
	"desc" => "Create a fifo special file (a named pipe)", 
	"docurl" => "function.posix-mkfifo.html" 
),
"posix_setegid" => array( 
	"methodname" => "posix_setegid", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool posix_setegid ( int gid )", 
	"snippet" => "( \${1:\$gid} )", 
	"desc" => "Set the effective GID of the current process", 
	"docurl" => "function.posix-setegid.html" 
),
"posix_seteuid" => array( 
	"methodname" => "posix_seteuid", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool posix_seteuid ( int uid )", 
	"snippet" => "( \${1:\$uid} )", 
	"desc" => "Set the effective UID of the current process", 
	"docurl" => "function.posix-seteuid.html" 
),
"posix_setgid" => array( 
	"methodname" => "posix_setgid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool posix_setgid ( int gid )", 
	"snippet" => "( \${1:\$gid} )", 
	"desc" => "Set the GID of the current process", 
	"docurl" => "function.posix-setgid.html" 
),
"posix_setpgid" => array( 
	"methodname" => "posix_setpgid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "int posix_setpgid ( int pid, int pgid )", 
	"snippet" => "( \${1:\$pid}, \${2:\$pgid} )", 
	"desc" => "Set process group id for job control", 
	"docurl" => "function.posix-setpgid.html" 
),
"posix_setsid" => array( 
	"methodname" => "posix_setsid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "int posix_setsid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Make the current process a session leader", 
	"docurl" => "function.posix-setsid.html" 
),
"posix_setuid" => array( 
	"methodname" => "posix_setuid", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool posix_setuid ( int uid )", 
	"snippet" => "( \${1:\$uid} )", 
	"desc" => "Set the UID of the current process", 
	"docurl" => "function.posix-setuid.html" 
),
"posix_strerror" => array( 
	"methodname" => "posix_strerror", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string posix_strerror ( int errno )", 
	"snippet" => "( \${1:\$errno} )", 
	"desc" => "Retrieve the system error message associated with the given errno", 
	"docurl" => "function.posix-strerror.html" 
),
"posix_times" => array( 
	"methodname" => "posix_times", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array posix_times ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get process times", 
	"docurl" => "function.posix-times.html" 
),
"posix_ttyname" => array( 
	"methodname" => "posix_ttyname", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string posix_ttyname ( int fd )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Determine terminal device name", 
	"docurl" => "function.posix-ttyname.html" 
),
"posix_uname" => array( 
	"methodname" => "posix_uname", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "array posix_uname ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get system name", 
	"docurl" => "function.posix-uname.html" 
),
"pow" => array( 
	"methodname" => "pow", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "number pow ( number base, number exp )", 
	"snippet" => "( \${1:\$base}, \${2:\$exp} )", 
	"desc" => "Exponential expression", 
	"docurl" => "function.pow.html" 
),
"preg_grep" => array( 
	"methodname" => "preg_grep", 
	"version" => "PHP4, PHP5", 
	"method" => "array preg_grep ( string pattern, array input [, int flags] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$input} )", 
	"desc" => "Return array entries that match the pattern", 
	"docurl" => "function.preg-grep.html" 
),
"preg_match_all" => array( 
	"methodname" => "preg_match_all", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int preg_match_all ( string pattern, string subject, array &matches [, int flags [, int offset]] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$subject}, \${3:\$matches} )", 
	"desc" => "Perform a global regular expression match", 
	"docurl" => "function.preg-match-all.html" 
),
"preg_match" => array( 
	"methodname" => "preg_match", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "mixed preg_match ( string pattern, string subject [, array &matches [, int flags [, int offset]]] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$subject} )", 
	"desc" => "Perform a regular expression match", 
	"docurl" => "function.preg-match.html" 
),
"preg_quote" => array( 
	"methodname" => "preg_quote", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "string preg_quote ( string str [, string delimiter] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Quote regular expression characters", 
	"docurl" => "function.preg-quote.html" 
),
"preg_replace_callback" => array( 
	"methodname" => "preg_replace_callback", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "mixed preg_replace_callback ( mixed pattern, callback callback, mixed subject [, int limit] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$callback}, \${3:\$subject} )", 
	"desc" => "Perform a regular expression search and replace using a callback", 
	"docurl" => "function.preg-replace-callback.html" 
),
"preg_replace" => array( 
	"methodname" => "preg_replace", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "mixed preg_replace ( mixed pattern, mixed replacement, mixed subject [, int limit [, int &count]] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$replacement}, \${3:\$subject} )", 
	"desc" => "Perform a regular expression search and replace", 
	"docurl" => "function.preg-replace.html" 
),
"preg_split" => array( 
	"methodname" => "preg_split", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "array preg_split ( string pattern, string subject [, int limit [, int flags]] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$subject} )", 
	"desc" => "Split string by a regular expression", 
	"docurl" => "function.preg-split.html" 
),
"prev" => array( 
	"methodname" => "prev", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed prev ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Rewind the internal array pointer", 
	"docurl" => "function.prev.html" 
),
"print_r" => array( 
	"methodname" => "print_r", 
	"version" => "PHP4, PHP5", 
	"method" => "bool print_r ( mixed expression [, bool return] )", 
	"snippet" => "( \${1:\$expression} )", 
	"desc" => "Prints human-readable information about a variable", 
	"docurl" => "function.print-r.html" 
),
"print" => array( 
	"methodname" => "print", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int print ( string arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Output a string", 
	"docurl" => "function.print.html" 
),
"printer_abort" => array( 
	"methodname" => "printer_abort", 
	"version" => "undefined", 
	"method" => "void printer_abort ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-abort.html" 
),
"printer_close" => array( 
	"methodname" => "printer_close", 
	"version" => "undefined", 
	"method" => "void printer_close ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-close.html" 
),
"printer_create_brush" => array( 
	"methodname" => "printer_create_brush", 
	"version" => "undefined", 
	"method" => "mixed printer_create_brush ( int style, string color )", 
	"snippet" => "( \${1:\$style}, \${2:\$color} )", 
	"desc" => "", 
	"docurl" => "function.printer-create-brush.html" 
),
"printer_create_dc" => array( 
	"methodname" => "printer_create_dc", 
	"version" => "undefined", 
	"method" => "void printer_create_dc ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-create-dc.html" 
),
"printer_create_font" => array( 
	"methodname" => "printer_create_font", 
	"version" => "undefined", 
	"method" => "mixed printer_create_font ( string face, int height, int width, int font_weight, bool italic, bool underline, bool strikeout, int orientation )", 
	"snippet" => "( \${1:\$face}, \${2:\$height}, \${3:\$width}, \${4:\$font_weight}, \${5:\$italic}, \${6:\$underline}, \${7:\$strikeout}, \${8:\$orientation} )", 
	"desc" => "", 
	"docurl" => "function.printer-create-font.html" 
),
"printer_create_pen" => array( 
	"methodname" => "printer_create_pen", 
	"version" => "undefined", 
	"method" => "mixed printer_create_pen ( int style, int width, string color )", 
	"snippet" => "( \${1:\$style}, \${2:\$width}, \${3:\$color} )", 
	"desc" => "", 
	"docurl" => "function.printer-create-pen.html" 
),
"printer_delete_brush" => array( 
	"methodname" => "printer_delete_brush", 
	"version" => "undefined", 
	"method" => "bool printer_delete_brush ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-delete-brush.html" 
),
"printer_delete_dc" => array( 
	"methodname" => "printer_delete_dc", 
	"version" => "undefined", 
	"method" => "bool printer_delete_dc ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-delete-dc.html" 
),
"printer_delete_font" => array( 
	"methodname" => "printer_delete_font", 
	"version" => "undefined", 
	"method" => "bool printer_delete_font ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-delete-font.html" 
),
"printer_delete_pen" => array( 
	"methodname" => "printer_delete_pen", 
	"version" => "undefined", 
	"method" => "bool printer_delete_pen ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-delete-pen.html" 
),
"printer_draw_bmp" => array( 
	"methodname" => "printer_draw_bmp", 
	"version" => "undefined", 
	"method" => "void printer_draw_bmp ( resource handle, string filename, int x, int y [, int width, int height] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$filename}, \${3:\$x}, \${4:\$y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-bmp.html" 
),
"printer_draw_chord" => array( 
	"methodname" => "printer_draw_chord", 
	"version" => "undefined", 
	"method" => "void printer_draw_chord ( resource handle, int rec_x, int rec_y, int rec_x1, int rec_y1, int rad_x, int rad_y, int rad_x1, int rad_y1 )", 
	"snippet" => "( \${1:\$handle}, \${2:\$rec_x}, \${3:\$rec_y}, \${4:\$rec_x1}, \${5:\$rec_y1}, \${6:\$rad_x}, \${7:\$rad_y}, \${8:\$rad_x1}, \${9:\$rad_y1} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-chord.html" 
),
"printer_draw_elipse" => array( 
	"methodname" => "printer_draw_elipse", 
	"version" => "undefined", 
	"method" => "void printer_draw_elipse ( resource handle, int ul_x, int ul_y, int lr_x, int lr_y )", 
	"snippet" => "( \${1:\$handle}, \${2:\$ul_x}, \${3:\$ul_y}, \${4:\$lr_x}, \${5:\$lr_y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-elipse.html" 
),
"printer_draw_line" => array( 
	"methodname" => "printer_draw_line", 
	"version" => "undefined", 
	"method" => "void printer_draw_line ( resource printer_handle, int from_x, int from_y, int to_x, int to_y )", 
	"snippet" => "( \${1:\$printer_handle}, \${2:\$from_x}, \${3:\$from_y}, \${4:\$to_x}, \${5:\$to_y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-line.html" 
),
"printer_draw_pie" => array( 
	"methodname" => "printer_draw_pie", 
	"version" => "undefined", 
	"method" => "void printer_draw_pie ( resource handle, int rec_x, int rec_y, int rec_x1, int rec_y1, int rad1_x, int rad1_y, int rad2_x, int rad2_y )", 
	"snippet" => "( \${1:\$handle}, \${2:\$rec_x}, \${3:\$rec_y}, \${4:\$rec_x1}, \${5:\$rec_y1}, \${6:\$rad1_x}, \${7:\$rad1_y}, \${8:\$rad2_x}, \${9:\$rad2_y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-pie.html" 
),
"printer_draw_rectangle" => array( 
	"methodname" => "printer_draw_rectangle", 
	"version" => "undefined", 
	"method" => "void printer_draw_rectangle ( resource handle, int ul_x, int ul_y, int lr_x, int lr_y )", 
	"snippet" => "( \${1:\$handle}, \${2:\$ul_x}, \${3:\$ul_y}, \${4:\$lr_x}, \${5:\$lr_y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-rectangle.html" 
),
"printer_draw_roundrect" => array( 
	"methodname" => "printer_draw_roundrect", 
	"version" => "undefined", 
	"method" => "void printer_draw_roundrect ( resource handle, int ul_x, int ul_y, int lr_x, int lr_y, int width, int height )", 
	"snippet" => "( \${1:\$handle}, \${2:\$ul_x}, \${3:\$ul_y}, \${4:\$lr_x}, \${5:\$lr_y}, \${6:\$width}, \${7:\$height} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-roundrect.html" 
),
"printer_draw_text" => array( 
	"methodname" => "printer_draw_text", 
	"version" => "undefined", 
	"method" => "void printer_draw_text ( resource printer_handle, string text, int x, int y )", 
	"snippet" => "( \${1:\$printer_handle}, \${2:\$text}, \${3:\$x}, \${4:\$y} )", 
	"desc" => "", 
	"docurl" => "function.printer-draw-text.html" 
),
"printer_end_doc" => array( 
	"methodname" => "printer_end_doc", 
	"version" => "undefined", 
	"method" => "bool printer_end_doc ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-end-doc.html" 
),
"printer_end_page" => array( 
	"methodname" => "printer_end_page", 
	"version" => "undefined", 
	"method" => "bool printer_end_page ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-end-page.html" 
),
"printer_get_option" => array( 
	"methodname" => "printer_get_option", 
	"version" => "undefined", 
	"method" => "mixed printer_get_option ( resource handle, string option )", 
	"snippet" => "( \${1:\$handle}, \${2:\$option} )", 
	"desc" => "", 
	"docurl" => "function.printer-get-option.html" 
),
"printer_list" => array( 
	"methodname" => "printer_list", 
	"version" => "undefined", 
	"method" => "array printer_list ( int enumtype [, string name [, int level]] )", 
	"snippet" => "( \${1:\$enumtype} )", 
	"desc" => "", 
	"docurl" => "function.printer-list.html" 
),
"printer_logical_fontheight" => array( 
	"methodname" => "printer_logical_fontheight", 
	"version" => "undefined", 
	"method" => "int printer_logical_fontheight ( resource handle, int height )", 
	"snippet" => "( \${1:\$handle}, \${2:\$height} )", 
	"desc" => "", 
	"docurl" => "function.printer-logical-fontheight.html" 
),
"printer_open" => array( 
	"methodname" => "printer_open", 
	"version" => "undefined", 
	"method" => "mixed printer_open ( [string devicename] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.printer-open.html" 
),
"printer_select_brush" => array( 
	"methodname" => "printer_select_brush", 
	"version" => "undefined", 
	"method" => "void printer_select_brush ( resource printer_handle, resource brush_handle )", 
	"snippet" => "( \${1:\$printer_handle}, \${2:\$brush_handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-select-brush.html" 
),
"printer_select_font" => array( 
	"methodname" => "printer_select_font", 
	"version" => "undefined", 
	"method" => "void printer_select_font ( resource printer_handle, resource font_handle )", 
	"snippet" => "( \${1:\$printer_handle}, \${2:\$font_handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-select-font.html" 
),
"printer_select_pen" => array( 
	"methodname" => "printer_select_pen", 
	"version" => "undefined", 
	"method" => "void printer_select_pen ( resource printer_handle, resource pen_handle )", 
	"snippet" => "( \${1:\$printer_handle}, \${2:\$pen_handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-select-pen.html" 
),
"printer_set_option" => array( 
	"methodname" => "printer_set_option", 
	"version" => "undefined", 
	"method" => "bool printer_set_option ( resource handle, int option, mixed value )", 
	"snippet" => "( \${1:\$handle}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "", 
	"docurl" => "function.printer-set-option.html" 
),
"printer_start_doc" => array( 
	"methodname" => "printer_start_doc", 
	"version" => "undefined", 
	"method" => "bool printer_start_doc ( resource handle [, string document] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-start-doc.html" 
),
"printer_start_page" => array( 
	"methodname" => "printer_start_page", 
	"version" => "undefined", 
	"method" => "bool printer_start_page ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "", 
	"docurl" => "function.printer-start-page.html" 
),
"printer_write" => array( 
	"methodname" => "printer_write", 
	"version" => "undefined", 
	"method" => "bool printer_write ( resource handle, string content )", 
	"snippet" => "( \${1:\$handle}, \${2:\$content} )", 
	"desc" => "", 
	"docurl" => "function.printer-write.html" 
),
"printf" => array( 
	"methodname" => "printf", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int printf ( string format [, mixed args [, mixed ...]] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Output a formatted string", 
	"docurl" => "function.printf.html" 
),
"proc_close" => array( 
	"methodname" => "proc_close", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int proc_close ( resource process )", 
	"snippet" => "( \${1:\$process} )", 
	"desc" => "Close a process opened by proc_open() and return the exit code of that   process.", 
	"docurl" => "function.proc-close.html" 
),
"proc_get_status" => array( 
	"methodname" => "proc_get_status", 
	"version" => "PHP5", 
	"method" => "array proc_get_status ( resource process )", 
	"snippet" => "( \${1:\$process} )", 
	"desc" => "Get information about a process opened by proc_open()", 
	"docurl" => "function.proc-get-status.html" 
),
"proc_nice" => array( 
	"methodname" => "proc_nice", 
	"version" => "PHP5", 
	"method" => "bool proc_nice ( int increment )", 
	"snippet" => "( \${1:\$increment} )", 
	"desc" => "Change the priority of the current process", 
	"docurl" => "function.proc-nice.html" 
),
"proc_open" => array( 
	"methodname" => "proc_open", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource proc_open ( string cmd, array descriptorspec, array &pipes [, string cwd [, array env [, array other_options]]] )", 
	"snippet" => "( \${1:\$cmd}, \${2:\$descriptorspec}, \${3:\$pipes} )", 
	"desc" => "Execute a command and open file pointers for input/output", 
	"docurl" => "function.proc-open.html" 
),
"proc_terminate" => array( 
	"methodname" => "proc_terminate", 
	"version" => "PHP5", 
	"method" => "int proc_terminate ( resource process [, int signal] )", 
	"snippet" => "( \${1:\$process} )", 
	"desc" => "kills a process opened by proc_open", 
	"docurl" => "function.proc-terminate.html" 
),
"pspell_add_to_personal" => array( 
	"methodname" => "pspell_add_to_personal", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_add_to_personal ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Add the word to a personal wordlist", 
	"docurl" => "function.pspell-add-to-personal.html" 
),
"pspell_add_to_session" => array( 
	"methodname" => "pspell_add_to_session", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_add_to_session ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Add the word to the wordlist in the current session", 
	"docurl" => "function.pspell-add-to-session.html" 
),
"pspell_check" => array( 
	"methodname" => "pspell_check", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool pspell_check ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Check a word", 
	"docurl" => "function.pspell-check.html" 
),
"pspell_clear_session" => array( 
	"methodname" => "pspell_clear_session", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_clear_session ( int dictionary_link )", 
	"snippet" => "( \${1:\$dictionary_link} )", 
	"desc" => "Clear the current session", 
	"docurl" => "function.pspell-clear-session.html" 
),
"pspell_config_create" => array( 
	"methodname" => "pspell_config_create", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_create ( string language [, string spelling [, string jargon [, string encoding]]] )", 
	"snippet" => "( \${1:\$language} )", 
	"desc" => "Create a config used to open a dictionary", 
	"docurl" => "function.pspell-config-create.html" 
),
"pspell_config_data_dir" => array( 
	"methodname" => "pspell_config_data_dir", 
	"version" => "PHP5", 
	"method" => "bool pspell_config_data_dir ( int conf, string directory )", 
	"snippet" => "( \${1:\$conf}, \${2:\$directory} )", 
	"desc" => "location of language data files", 
	"docurl" => "function.pspell-config-data-dir.html" 
),
"pspell_config_dict_dir" => array( 
	"methodname" => "pspell_config_dict_dir", 
	"version" => "PHP5", 
	"method" => "bool pspell_config_dict_dir ( int conf, string directory )", 
	"snippet" => "( \${1:\$conf}, \${2:\$directory} )", 
	"desc" => "Location of the main word list", 
	"docurl" => "function.pspell-config-dict-dir.html" 
),
"pspell_config_ignore" => array( 
	"methodname" => "pspell_config_ignore", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_ignore ( int dictionary_link, int n )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$n} )", 
	"desc" => "Ignore words less than N characters long", 
	"docurl" => "function.pspell-config-ignore.html" 
),
"pspell_config_mode" => array( 
	"methodname" => "pspell_config_mode", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_mode ( int dictionary_link, int mode )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$mode} )", 
	"desc" => "Change the mode number of suggestions returned", 
	"docurl" => "function.pspell-config-mode.html" 
),
"pspell_config_personal" => array( 
	"methodname" => "pspell_config_personal", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_personal ( int dictionary_link, string file )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$file} )", 
	"desc" => "Set a file that contains personal wordlist", 
	"docurl" => "function.pspell-config-personal.html" 
),
"pspell_config_repl" => array( 
	"methodname" => "pspell_config_repl", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_repl ( int dictionary_link, string file )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$file} )", 
	"desc" => "Set a file that contains replacement pairs", 
	"docurl" => "function.pspell-config-repl.html" 
),
"pspell_config_runtogether" => array( 
	"methodname" => "pspell_config_runtogether", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_runtogether ( int dictionary_link, bool flag )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$flag} )", 
	"desc" => "Consider run-together words as valid compounds", 
	"docurl" => "function.pspell-config-runtogether.html" 
),
"pspell_config_save_repl" => array( 
	"methodname" => "pspell_config_save_repl", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_config_save_repl ( int dictionary_link, bool flag )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$flag} )", 
	"desc" => "Determine whether to save a replacement pairs list   along with the wordlist", 
	"docurl" => "function.pspell-config-save-repl.html" 
),
"pspell_new_config" => array( 
	"methodname" => "pspell_new_config", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_new_config ( int config )", 
	"snippet" => "( \${1:\$config} )", 
	"desc" => "Load a new dictionary with settings based on a given config", 
	"docurl" => "function.pspell-new-config.html" 
),
"pspell_new_personal" => array( 
	"methodname" => "pspell_new_personal", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_new_personal ( string personal, string language [, string spelling [, string jargon [, string encoding [, int mode]]]] )", 
	"snippet" => "( \${1:\$personal}, \${2:\$language} )", 
	"desc" => "Load a new dictionary with personal wordlist", 
	"docurl" => "function.pspell-new-personal.html" 
),
"pspell_new" => array( 
	"methodname" => "pspell_new", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_new ( string language [, string spelling [, string jargon [, string encoding [, int mode]]]] )", 
	"snippet" => "( \${1:\$language} )", 
	"desc" => "Load a new dictionary", 
	"docurl" => "function.pspell-new.html" 
),
"pspell_save_wordlist" => array( 
	"methodname" => "pspell_save_wordlist", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_save_wordlist ( int dictionary_link )", 
	"snippet" => "( \${1:\$dictionary_link} )", 
	"desc" => "Save the personal wordlist to a file", 
	"docurl" => "function.pspell-save-wordlist.html" 
),
"pspell_store_replacement" => array( 
	"methodname" => "pspell_store_replacement", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int pspell_store_replacement ( int dictionary_link, string misspelled, string correct )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$misspelled}, \${3:\$correct} )", 
	"desc" => "Store a replacement pair for a word", 
	"docurl" => "function.pspell-store-replacement.html" 
),
"pspell_suggest" => array( 
	"methodname" => "pspell_suggest", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array pspell_suggest ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Suggest spellings of a word", 
	"docurl" => "function.pspell-suggest.html" 
),
"putenv" => array( 
	"methodname" => "putenv", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void putenv ( string setting )", 
	"snippet" => "( \${1:\$setting} )", 
	"desc" => "Sets the value of an environment variable", 
	"docurl" => "function.putenv.html" 
),

); # end of main array
?>