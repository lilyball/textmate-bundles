#!/usr/bin/env ruby -KU

###################################
#
# R daemon for HTML Help pages
#
# written by Hans-Jörg Bibiko - bibiko@eva.mpg.de
###################################

require 'pty'
require 'fileutils'

$bgThread = nil;

cmd = "R -q --encoding=UTF-8 --TMRHelperDaemon 2&> /tmp/r_helper_dummy_out"

PTY.spawn(cmd) { |r,w,pid|

	r.sync = FALSE

	# write r to the nirvana
	Thread.new {
		r.read
	}

	# Timer to destroy daemon
	$bgThread = Thread.new do
		sleep 600
		w.puts("q('no')")
		FileUtils.rm_f("/tmp/r_helper_dummy")
		FileUtils.rm_f("/tmp/r_helper_dummy_out")
	end

	
	fin = File.open('/tmp/r_helper_dummy', "r+")
	while TRUE
		
		task = fin.gets
		
		# Kill Timer
		$bgThread.kill
		w.puts task

		# Restart Timer to destroy daemon
		$bgThread = Thread.new do
			sleep 600
			w.puts("q('no')")
			FileUtils.rm_f("/tmp/r_helper_dummy")
			FileUtils.rm_f("/tmp/r_helper_dummy_out")
		end
	end
}