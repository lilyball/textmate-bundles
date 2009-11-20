#################################################################################################
# start script for TextMate's Rdaemon
#
#   this file is loaded via "sys.source(...,  envir = attach(NULL, name = "Rdaemon"))"
#
#
#
####### please change the following lines only if you know what do you are doing

#the following two lines MUST NOT BE CHANGED - otherwise Rdaemon will freeze!
options(prompt = "> ")
options(continue = "+ ")

# options for outputting
options(pager = "/bin/cat")
options(echo = T)
options(editor = "mate -w")
options(htmlhelp = T)
options(help_type = "html")
options(menu.graphics = F)
options(repos = list(CRAN="http://cran.cnr.Berkeley.edu"))
options(width = 100)
options(device = "quartz")
options(keep.source = FALSE)

# options for plotting
formals(pdf)[c("file", "width", "height")] <- list("./plots/Rplot%03d.pdf", 10, 10)
formals(png)[c("filename", "width", "height", "bg", "res")] <- list("./plots/Rplot%03d.png", 700, 700, "transparent", 150)
formals(jpeg)[c("filename", "width", "height")] <- list("./plots/Rplot%03d.jpeg", 700, 700)


