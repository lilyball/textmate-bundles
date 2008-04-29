#################################################################################################
# start script for TextMate's Rdaemon

# load function for "Insert Command Template"
#source("~/Rdaemon/help/getSig.R")

# load start options
sys.source("~/Rdaemon/myBase.R", envir = environment(readline))
sys.source("~/Rdaemon/myUtils.R", envir = environment(menu))
sys.source("~/Rdaemon/startOptions.R", envir = attach(NULL, name = "Rdaemon"))

#################################################################################################
######### user defined start options => edit startOptions.R

