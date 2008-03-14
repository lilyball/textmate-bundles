f0815<-function(){
loaded.pkgs <- .packages()
x <- library()
x <- x$results[x$results[, 1] != "base", ]
pkgsraw <- x[, 1]
pkgs <- paste("<td>",x[, 1],"</td>",sep="")
pkgs.desc <- paste("<td>",x[, 3],"</td>",sep="")
is.loaded <- !is.na(match(pkgsraw, loaded.pkgs))
pkgs.status <- character(length(is.loaded))
pkgs.status[which(is.loaded)] <- paste("<tr><td align=center><input name=\"",pkgsraw[which(is.loaded)],"\" onchange=\"pkgMan(this);\" type=\"checkbox\" checked></td>",sep="")
pkgs.status[which(!is.loaded)] <- paste("<tr><td align=center><input name=\"",pkgsraw[which(!is.loaded)],"\" onchange=\"pkgMan(this);\" type=\"checkbox\"></td>",sep="")
pkgs.url <- paste("<td align=center><span class='helpSym' onclick=\"TextMate.system('open  file://", file.path(.find.package(pkgsraw), "html", "00Index.html") , "',null)\">&nbsp;?&nbsp;</span></td></tr>",sep="")
cat("<span style='font-family:Lucida Grande'><span style='font-size:11pt;font-weight:bold'>Package Manager</span><table border=1 frame=box rules=groups cellspacing=2mm style='margin:2mm; font-size:8pt; collapse:collapse;'><tr><thead bgcolor=lightgrey><td><b>loaded</b><td><b>Package</b><td><b>Description</b><td><b>Info</b><tbody>")
cat(paste(pkgs.status,pkgs,pkgs.desc,pkgs.url,sep="\n"))
}
f0815()
cat("</table></span><small>")
rm(f0815)
