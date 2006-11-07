# This file is just used for testing getSig.R
# I committed it to the repo so it can be used for further maintenance of getSig.R
#
# Kevin Ballard

source("./getSig.R")

cat(paste(getSig(if ('p' %in% (ary <- sort(apropos('^p', mode='function')))) 'p' else ary), collapse='\n'))
