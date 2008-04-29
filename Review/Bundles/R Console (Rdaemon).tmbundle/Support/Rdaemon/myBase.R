#################################################################################################
# start script for TextMate's Rdaemon
#
#   this file is loaded via "sys.source(...,  envir = environment(readline))"
#   to overwrite some functions defined in the package 'utils'
#
#
####### please change the following lines only if you know what do you are doing

unlockBinding("readline", environment(readline))
readline <- function(prompt = "") {
	res=system(paste("~/Rdaemon/daemon/readline.sh", " '", prompt, "'",  sep=''), intern=T)
	return(res)
}
lockBinding("readline", environment(readline))