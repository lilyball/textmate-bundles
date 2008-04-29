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
options(menu.graphics = F)
# if (getOption("repos")[[1]] == "@CRAN@") 
# 	options(repos = "http://cran.cnr.Berkeley.edu")
options(width = 100)
options(device = "quartz")
options(keep.source = FALSE)

file.edit <- function(..., title = file, editor = "mate") {
	file <- c(...)
	.Internal(file.edit(file, rep(as.character(title), len = length(file)), 
		editor))
}

file.choose <- function() {
	system("osascript -e 'tell application \"TextMate\"' -e 'activate' -e 'POSIX path of (choose file)' -e 'end tell' 2>/dev/null", intern=T)
}

menu <- function(choises, graphics=FALSE,  title="Rdaemon") {
	res=system(paste("~/Rdaemon/daemon/menu.sh", " '", paste('"', choises, '"', sep='', collapse=','), "' '", title, "'",  sep=''), intern=T)
	return(ifelse(length(which(choises==res))>0, which(choises==res),  0))
}

alarm <- function() {
	system("osascript -e beep")
}

# options for plotting
formals(pdf)[c("file", "width", "height")] <- list("~/Rdaemon/plots/Rplot%03d.pdf", 10, 10)
formals(png)[c("filename", "width", "height",  "bg",  "res")] <- list("~/Rdaemon/plots/Rplot%03d.png", 900, 900, "transparent", 150)
formals(jpeg)[c("filename", "width", "height")] <- list("~/Rdaemon/plots/Rplot%03d.png", 900, 900)

quartz <- function(display = "", width = 9, height = 9, pointsize = 12, 
	family = "Helvetica", antialias = TRUE, autorefresh = TRUE) {
	library(CarbonEL)
	.External("Quartz", display, width, height, pointsize, 
		family, antialias, autorefresh, PACKAGE = "grDevices")
	invisible()
}


.chooseActiveScreenDevice <- function() {
	plots <- dev.list()
	out <- ""
	if (length(plots) > 0) {
		actPlot <- dev.cur()
		randomNum <- rnorm(1, mean = 10) * 1e+05
		plotPathPref <- paste("file://", Sys.getenv("HOME"), 
			"/Rdaemon/plots/tmp/Rplot_", randomNum, "_", 
			sep = "", collapse = "")
		for (i in 1:(length(plots))) {
			borderCol <- ifelse(actPlot == plots[i], "red", 
			  "#DDDDDD")
			btnVisibility <- ifelse(actPlot == plots[i], 
			  "hidden", "visible")
			if (!names(plots[i]) %in% c("pdf", "postscript")) {
			  dev.set(plots[i])
			  out <- paste(out, "<div id='dev", plots[i], 
				"'><h3>Device ", plots[i], " (", names(plots[i]), 
				")</h3>", sep = "", collapse = "")
			  out <- paste(out, "<img onclick='setAct(this.id)' id=", 
				plots[i], "_", (i - 1), " style='border:3px solid ", 
				borderCol, "' width=90% src='", plotPathPref, 
				sprintf("%03d", plots[i]), ".pdf", "'/><br>", 
				sep = "", collapse = "")
			  dev.print(pdf, file = paste("~/Rdaemon/plots/tmp/Rplot_", 
				randomNum, "_", sprintf("%03d", plots[i]), 
				".pdf", sep = "", collapse = ""))
			  out <- paste(out, "<button style='visibility:", 
				btnVisibility, "' id=", plots[i], "_", (i - 
				  1), " onclick='closeMe(this.id)'>Close Device</button>", 
				sep = "", collapse = "")
			  out <- paste(out, "<input type='button' id=", 
				plots[i], "_", (i - 1), " onclick='saveMe(this.id)' value='Save'>", 
				sep = "", collapse = "")
			  out <- paste(out, "</div>", sep = "", collapse = "")
			}
			else {
			  out <- paste(out, "<div id='dev", plots[i], 
				"'><h3>Device ", plots[i], " (", names(plots[i]), 
				")</h3>", "<font color=red>is not a screen device</font>", 
				sep = "", collapse = "")
			  out <- paste(out, "<img onclick='setAct(this.id)' id=", 
				plots[i], "_", (i - 1), " style='border:3px solid ", 
				borderCol, "' width=90% src='file://", Sys.getenv("HOME"), 
				"/Rdaemon/daemon/dummy_noimage.pdf'/><br>", 
				sep = "", collapse = "")
			  out <- paste(out, "<button style='visibility:", 
				btnVisibility, "' id=", plots[i], "_", (i - 
				  1), " onclick='closeMe(this.id)'>Close Device</button>", 
				sep = "", collapse = "")
			  out <- paste(out, "</div>", sep = "", collapse = "")
			}
		}
		dev.set(actPlot)
	}
	out
}


#################################################################################################
######### user defined start options here:
