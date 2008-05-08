function [a,b,c] = test_indentation(c, d, e)
	% TEST_INDENTATION   A function to test the Matlab bundle for TextMate
	%		[[A,B,C]] = TEST_INDENTATION(C, D, E)
	%
	%	Doesn't really do anything... This is more to test indentation etc.
	%	
	%	Created by Matt Foster on 2008-05-08.

	% First, a quick if statement:
	if rem(n,2) ~= 0
		M = odd_magic(n)
	elseif rem(n,4) ~= 0 % Ideally, this will still be indented.
		M = single_even_magic(n)
	else
		M = double_even_magic(n)
	end

	%{
	Here's a block comment.
	%}

	% Now, a switch
	switch var
	case a % when a
		something
	case b
		something
	otherwise
		soomething 
	end

	% And a try -- catch
	try 
		100 ./ 0
	catch
		error('Caught problem')
	end

	% Finally, some while loops.
	while a < 100
		a = a + 1;
	end

	while a < 100
		a = a + 1;
		if mod(a, 2) == 2
			disp('a is even');
		end
		if a > 100
			break;
		end
	endwhile % Octave style
