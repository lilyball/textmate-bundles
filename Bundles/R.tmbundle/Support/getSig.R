getSig <- function (names) {
	sapply(names, function(name, snipIdx=0)
		paste(c(name, "(", sapply(lapply(names(f <- formals(name)), function (name) if ((fdep <- paste(deparse(f[[name]], width=500), collapse="\n")) == "") name else list(name, fdep)), function(arg)
				if (is.list(arg))
					paste("${", (snipIdx <<- snipIdx + 1), ":", if (snipIdx > 1) ", " else "", arg[[1]], "=${",
							snipIdx <<- snipIdx + 1, ":",
							if ((pos <- regexpr("(?<=^['\"]).*(?=['\"]$)", arg[[2]], perl=T)) != -1)
								paste(substr(arg[[2]], 1, pos-1), "${", snipIdx <<- snipIdx + 1, ":", substr(arg[[2]], pos, pos + attr(pos,"match.length") - 1), "}", substr(arg[[2]], pos + attr(pos, "match.length"), nchar(arg[[2]])), sep="")
							else
								arg[[2]]
							, "}}", sep="")
				else
					paste(if (snipIdx > 0) ", " else "", "${", (snipIdx <<- snipIdx + 1), ":", arg, "}", sep="")
			), ")")
		, collapse="")
	)
}
