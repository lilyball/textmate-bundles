function [a, b, c] = test_both(a, b, c) % Both input and output arguments
function a = test_both(a, b, c)
function test_input(a, b, c)
function test_neither
function aa = test

% TODO: Highly crazy, and yet valid syntax.
% at least it's detected as a function!
function bb = test3 ...
	(a, b, c)

% Octave style testing:
function test_neither_hash # comment
function [a, b, c] = test_both_hash(a, b, c) # Both input and output arguments
