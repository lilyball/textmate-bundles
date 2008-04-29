#################################################################################################
# start script for TextMate's Rdaemon
#
#   this file is loaded via "sys.source(...,  envir = environment(menu))"
#   to overwrite some functions defined in the package 'utils'
#
#
####### please change the following lines only if you know what do you are doing

unlockBinding("menu", environment(menu))
menu <- function(choises, graphics=FALSE,  title="Rdaemon") {
	res=system(paste("~/Rdaemon/daemon/menu.sh", " '", paste('"', choises, '"', sep='', collapse=','), "' '", title, "'",  sep=''), intern=T)
	return(which(choises==res))
}
lockBinding("menu", environment(menu))