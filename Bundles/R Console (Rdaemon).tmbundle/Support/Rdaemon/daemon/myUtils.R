#################################################################################################
# start script for TextMate's Rdaemon
#
#   this file is loaded via "sys.source(...,  envir = environment(menu))"
#   to overwrite some functions defined in the package 'utils'
#
#
####### please change the following lines only if you know what do you are doing

unlockBinding("menu", environment(menu))
menu <- function(choises, graphics=FALSE, title="Rdaemon") {
	res=system(paste("~/Rdaemon/daemon/menu.sh", " '", paste('"', choises, '"', sep='', collapse=','), "' '", title, "'",  sep=''), intern=T)
	return(ifelse(length(which(choises==res))>0, which(choises==res),  0))
}
lockBinding("menu", environment(menu))

unlockBinding("select.list", environment(select.list))
select.list <- function(list, preselect = NULL, multiple = FALSE, title="Rdaemon") {
	if(multiple) {
		multipleArg <- "with multiple selections allowed"
	} else {
		multipleArg <- ""
		if(!is.null(preselect)) preselect <- preselect[1]
	}
	res=system(paste("~/Rdaemon/daemon/selectlist.sh", " '", paste('"', list, '"', sep='', collapse=','), "' '", title, "' '", paste('"', preselect, '"', sep='', collapse=','), "' '", multipleArg, "'", sep=''), intern=T)
	res <- unlist(strsplit(res, "!@#@!"))[-1]
	if(!length(res)) return(character(0))
	return(res)
}
lockBinding("select.list", environment(select.list))
