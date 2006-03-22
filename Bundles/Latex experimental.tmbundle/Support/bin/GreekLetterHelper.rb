#!/usr/bin/env ruby
shortcutHash = {
"a" => "\\alpha",
"b" => "\\beta",
"g" => "\\gamma",
"d" => "\\delta",
"th" => "\\delta",
"e" => "\\epsilon",
"f" => "\\phi",
"ph" => "\\phi",
"vf" => "\\varphi",
"vph" => "\\varphi",
"i" => "\\iota",
"z" => "\\zeta",
"h" => "\\eta",
"th" => "\\theta",
"vth" => "\\vartheta",
"k" => "\\kappa",
"l" => "\\lambda",
"m" => "\\mu",
"n" => "\\nu",
"x" => "\\chi",
"p" => "\\pi",
"r" => "\\rho",
"s" => "\\sigma",
"vs" => "\\varsigma",
"t" => "\\tau",
"u" => "\\upsilon",
"y" => "\\upsilon",
"w" => "\\omega",
"v" => "\\xi",
"ks" => "\\xi",
"ps" => "\\psi",
"G" => "\\Gamma",
"D" => "\\Delta",
"F" => "\\Phi",
"L" => "\\Lambda",
"X" => "\\Chi",
"P" => "\\Pi",
"S" => "\\Sigma",
"U" => "\\Upsilon",
"Y" => "\\Upsilon",
"W" => "\\Omega",
"Ps" => "\\Psi",
"PS" => "\\Psi",
"V" => "\\Xi",
"Ks" => "\\Xi",
"KS" => "\\Xi",
"TH" => "\\Theta",
"Th" => "\\Theta"
}
shortcutHash.default = "«press a-z and space for greek letter»"
currentWord = STDIN.read
if (shortcutHash.has_key?(currentWord)) then
 print shortcutHash[currentWord]
else
  print currentWord + shortcutHash.default
end