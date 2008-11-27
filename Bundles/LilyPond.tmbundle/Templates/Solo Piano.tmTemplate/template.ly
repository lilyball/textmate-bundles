\header{
	filename = "${TM_NEW_FILE_BASENAME}.ly"
	composer          = "${TM_FULLNAME}"
	title             = "${TM_NEW_FILE_BASENAME}"

	copyright         = "Creative Commons Attribution-ShareAlike 2.5"
	maintainer        = "${TM_FULLNAME}"
	lastupdated       = "${TM_DATE}"
}

\version "${TM_LILY_VERSION}"



upper = \relative c'' {
	\clef treble
	\key c \major
	\time 4/4
	
	a b c d
}

lower = \relative c {
	\clef bass
	\key c \major
	\time 4/4
	
	a2 c
}

\score {
	\new PianoStaff <<
		\set PianoStaff.instrument = "Piano  "
		\new Staff = "upper" \upper
		\new Staff = "lower" \lower
	>>
	\layout { }
	\midi { \tempo 4=60 }
}