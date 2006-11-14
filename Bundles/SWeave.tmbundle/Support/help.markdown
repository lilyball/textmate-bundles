Sweave bundle for TextMate
==========================

Introduction
------------

This bundle produces basic Sweave funcationality in TextMate. It doesn't do anything fancy, but at this time handles code highlighting and the compilation of Sweave documents into corresponding LaTeX files. 

The bundle works in conjunction with the R bundle by using the same context for embedded R code: Use the regular couple of R commands to send code to R from TextMate.

**Last modified**: 2006-08-24

Using the bundle
----------------

###Language

The Sweave bundle uses a simple language configuration, essentially copying a couple of elements from the R and LaTeX bundles and adding code to recognize Sweave code within a document. Sweave files get the overall context of text.latex.sweave; this prevents the bundle from hijacking the gear menu for regular LaTeX files while allowing for the use of all the features of the LaTeX bundle within Sweave files. It also parses \Sexpr{} commands inline and assigns them the context meta.sweave.latex so that they can be given their own color highlighting.

###Usage

Usage is straightforward. There are two main commands: **Sweave in R** and **Sweave project in R**. The former sources the current Snw file in R, after which the resulting .tex file can be compiled via the LaTeX Bundle's build command (now **cmd-R**). **Sweave project in R** is in place for building larger projects, or for example when the current file depends on other data or variables being built first. To use the sweave project command, set TM_SWEAVE_MASTER in the project variables. 

If you prefer using the command-line R/Sweave interface, Ana Nelson has written a command that compiles your Sweave code via the R bundle's tmR.rb script. From Ana's [post](http://comox.textdrive.com/pipermail/textmate/2006-July/011835.html) to the mailing list:

> Note this assumes both R and Sweave bundles are located in the same  
directory. The /../../ is to back up from the Sweave bundle Support  
directory and go into the R bundle Support directory.

Typeset: When using the Sweave Bundle, you should always set the TM_LATEX_MASTER variable so that you can use the normal LaTeX compile command. Set this either to the master .tex file that includes your Sweave-built files, or to the name of your working Sweave file, with .tex substituted for the Snw/Rnw extension. If you haven't set this variable, you can use the LaTeX typeset command built in to the Sweave bundle. However, the typeset command in the LaTeX bundle is likely to be more recently-updated, so it's preferable to simply set TM_LATEX_MASTER.



###Other elements

The bundle includes a couple of snippets and commands that are as useful in R as they are in Sweave:

* Underscore (_) generates the R symbol <-. This is a familiar convention from  emacs' ESS package. (Longer-term, it makes sense to shift this over to the R bundle.)
* Insert section/figure: Quick snippets for boilerplate Sweave section and figure blocks.

Misc
----

###Feedback and thanks

Putting this bundle together was a first for me and I'm sure it could use any number of improvements and refinements -- all of which are welcome. Thanks to the TextMate community for all the help in getting this off the ground.

####Contact

* alan at schussman.com

