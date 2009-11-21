#################################################################################################
# start script for TextMate's Rdaemon

# load function for "Insert Command Template"
#source("~/Library/Application Support/Rdaemon/help/getSig.R")

# load start options
sys.source("~/Library/Application Support/Rdaemon/daemon/myBase.R", envir = environment(readline))
sys.source("~/Library/Application Support/Rdaemon/daemon/myUtils.R", envir = environment(menu))
sys.source("~/Library/Application Support/Rdaemon/daemon/myStartOptions.R", envir = attach(NULL, name = "Rdaemon"))
# sys.source("~/Library/Application Support/Rdaemon/startOptions.R", envir = attach(NULL, name = "Rdaemon"))
source("~/Library/Application Support/Rdaemon/startOptions.R")

#################################################################################################
######### user defined start options => edit startOptions.R

