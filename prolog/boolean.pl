and(true,true,true).
and(_, false,false).
and(false, _, false).

or(true,_,true).
or(_,true,true).
or(false,false,false).

not(true,false).
not(false,true).

eval(true).
eval(false).

eval(X,X):-
	eval(X).

eval(and(X,Y),R):-
	eval(X,XV),
	eval(Y,YV),
	and(XV,YV,R).

eval(or(X,Y),R):-
	eval(X,XV),
	eval(Y,YV),
	or(XV,YV,R).

eval(not(X),R):-
	eval(X,XV),
	not(XV,R).