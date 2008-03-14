#!/usr/bin/env ruby -KU

###################################
#
# R daemon
#
# reads on r_in
# writes R's output to r_out
#
# written by Hans-Jörg Bibiko - bibiko@eva.mpg.de
###################################

require 'pty'

$rdout = File.join(ENV['HOME'], "Rdaemon")

$fhist = File.open($rdout + '/history/Rhistory.txt', "a")

#cmd = "R --encoding=UTF-8 --TMRdaemon 2> " + $rdout + "/r_err 1> " + $rdout + "/r_out"
#cmd = "R --encoding=UTF-8 --TMRdaemon 2&> " + $rdout + "/r_out"
if ENV['TM_RdaemonRAMDRIVE'] == "1"
	cmd = "R -q --encoding=UTF-8 --TMRdaemon 2&> /tmp/TMRramdisk1/r_out"
else
	cmd = "R -q --encoding=UTF-8 --TMRdaemon 2&> " + $rdout + "/r_out"
end

PTY.spawn(cmd) { |r,w,pid|
	# write init stuff to R
	w.puts(%{source("#{$rdout}/daemon/start.r")})
	r.sync = FALSE

	# write r to the nirvana
	Thread.new {
		r.read
	}
	
	fin = File.open($rdout + '/r_in', "r+")
	while TRUE
		#wait for a new task and send it to R
		task = fin.gets
		$fhist.puts task.gsub(/^ +/,'').gsub(/^\t+/,'') if !task.match('^@\|') && !task.empty? && task != "\n"
		task.gsub!(/^@\|/, '')
		$fhist.flush
		w.puts task
	end
}