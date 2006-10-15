#!/usr/bin/env ruby
#
#####################
# Helper function
#####################
def recursiveFileSearch(initialList)
  extraPathList = []
  regexp = /\\(?:include|input)\{([^}]*)\}/   # ?: don't capture group
  visitedFilesList = Hash.new
  tempFileList = initialList.clone
  listToReturn = Array.new
  until (tempFileList.empty?) 
    filename = tempFileList.shift
    # Have we visited this file already?
    unless visitedFilesList.has_key?(filename) then
      visitedFilesList[filename] = filename
      # First, find file's path.
      filepath = File.dirname(filename) + "/"
      File.open(filename) do |file|
        file.each do |line|
          # search for links
          if line.match(regexp) then
            m = $1
            # Need to deal with the case of multiple words here, separated by comma.
            list = m.split(',')
            list.each do |item|
              item.strip!
              # need to look at all paths in extraPathList for the file
              (extraPathList << filepath).each do |path|
                testFilePath = path + if (item.slice(-4,4) != ".#{fileExt}") then item + ".#{fileExt}" else item end
                if File.exist?(testFilePath) then
                  listToReturn << testFilePath
                  if (fileExt == "tex") then tempFileList << testFilePath end
                  if block_given? then 
                    File.open(testFilePath) {|file| yield file}
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return listToReturn
end
######################
# Program start
######################
#
# Work with the current file; if TM_LATEX_MASTER is set, work with both
# Thanks to Alan Schussman
#
filelist = []
filelist << ENV["TM_FILEPATH"] if ENV.has_key?("TM_FILEPATH")
filelist << ENV["TM_LATEX_MASTER"] if ENV.has_key?("TM_LATEX_MASTER")
# Recursively find all relevant files. Don't forget to include current files
filelist += recursiveFileSearch(filelist)
# Get word prefix to expand
# if !(ENV.has_key?("TM_CURRENT_WORD")) then
# matchregex = /\\#{ENV["TM_CURRENT_WORD"] || ""}\w+/
# end
# Process the filelist looking for all matching commands.
completionslist = [ 'aleph', 'alpha', 'amalg', 'angle', 'approx', 'arccos', 'arccosh', 'arcsin', 'arcsinh', 'arctan', 'arctanh', 'ast', 'backprime', 'barwedge', 'Bbbk', 'because', 'beta', 'bigcap', 'bigcirc', 'bigcup', 'bigodot', 'bigoplus', 'bigotimes', 'bigskip', 'bigstar', 'bigtriangledown', 'bigtriangleup', 'biguplus', 'bigvee', 'bigwedge', 'blacksquare', 'blacktriangle', 'blacktriangledown', 'blacktriangleleft', 'blacktriangleright', 'Box', 'boxdot', 'boxminus', 'boxplus', 'boxtimes', 'bullet', 'Cap', 'cap', 'cdot', 'cdots', 'centerdot', 'Chi', 'chi', 'circ', 'circledast', 'circledcirc', 'circleddash', 'circledS', 'cite', 'clubsuit', 'colon', 'complement', 'cong', 'cos', 'cosh', 'Cup', 'cup', 'curlyvee', 'curlywedge', 'dagger', 'dashv', 'ddagger', 'ddots', 'Delta', 'delta', 'diagdown', 'diagup', 'Diamond', 'diamond', 'diamondsuit', 'Digamma', 'digamma', 'displaystyle', 'div', 'divideontimes', 'doteq', 'dotplus', 'dots', 'Downarrow', 'downarrow', 'ell', 'emptyset', 'epsilon', 'eqref', 'equiv', 'eta', 'eth', 'exists', 'exp', 'Finv', 'flat', 'forall', 'frac', 'Game', 'Gamma', 'gamma', 'ggg', 'grtsim', 'hbar', 'heartsuit', 'hookleftarrow', 'hookrightarrow', 'hslash', 'iff', 'iiint', 'iint', 'imath', 'implies', 'inf', 'infty', 'int', 'intercal', 'iota', 'jmath', 'kappa', 'label', 'Lambda', 'lambda', 'langle', 'lceil', 'ldots', 'Leftarrow', 'leftarrow', 'leftharpoondown', 'leftharpoonup', 'Leftrightarrow', 'leftrightarrow', 'leftthreetimes', 'leq', 'leqq', 'lesssim', 'lfloor', 'lim', 'liminf', 'limsup', 'lll', 'log', 'Longleftarrow', 'longleftarrow', 'Longleftrightarrow', 'longleftrightarrow', 'longmapsto', 'Longrightarrow', 'longrightarrow', 'lozenge', 'ltimes', 'mapsto', 'mathbb', 'max', 'measuredangle', 'medskip', 'mho', 'mid', 'min', 'mu', 'nabla', 'natural', 'nearrow', 'neq', 'nexists', 'nonumber', 'not', 'notin', 'nu', 'nwarrow', 'odot', 'oint', 'Omega', 'omega', 'ominus', 'oplus', 'oslash', 'otimes', 'partial', 'perp', 'Phi', 'phi', 'Pi', 'pi', 'prec', 'preccurlyeq', 'preceq', 'prod', 'propto', 'Psi', 'psi', 'qquad', 'quad', 'rangle', 'rceil', 'Re', 'ref', 'rfloor', 'rhd', 'rho', 'Rightarrow', 'rightarrow', 'rightharpoondown', 'rightharpoonup', 'rightthreetimes', 'rtimew', 'scriptscriptstyle', 'scriptstyle', 'searrow', 'setminus', 'sharp', 'Sigma', 'sigma', 'sim', 'simeq', 'sin', 'sinh', 'smallsetminus', 'smallskip', 'spadesuit', 'sphericalangle', 'sqcap', 'sqcup', 'sqrt', 'square', 'star', 'Subset', 'subset', 'subseteq', 'subseteqq', 'succ', 'succcurlyeq', 'succeq', 'sum', 'sup', 'supp', 'Supset', 'supset', 'supseteq', 'supseteqq', 'surd', 'swarrow', 'tan', 'tanh', 'tau', 'textstyle', 'therefore', 'Theta', 'theta', 'times', 'top', 'triangle', 'triangledown', 'triangleleft', 'triangleright', 'Uparrow', 'uparrow', 'Updownarrow', 'updownarrow', 'uplus', 'Upsilon', 'upsilon', 'varepsilon', 'varkappa', 'varnothing', 'varphi', 'varpi', 'varrho', 'varsigma', 'vartheta', 'vartriangle', 'vdash', 'vdots', 'vee', 'veebar', 'wedge', 'xi', 'zeta']

filelist.uniq.each {|filename|
  File.open("#{filename}") do |theFile|
    completionslist += theFile.read.scan(/\\(\w+)/).map{|i| i[0]}.reject{|i| i.length <= 2}
  end
}
completionslist = completionslist.grep(/^#{ENV['TM_CURRENT_WORD']}/) unless ENV['TM_CURRENT_WORD'].nil?
print completionslist.uniq.sort.join("\n")
