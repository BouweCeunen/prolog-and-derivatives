
%% The goal is to get the mineral by removing sand layers and/or ice layers

:-include(kplanner).

prim_action(putAwayMineral,[ok]).				% putAwayMineral as final step
prim_action(removeIceLayer,[ok]).				% remove iceLayer
prim_action(removeSandLayer,[ok]).				% remove sandLayer
prim_action(senseSandLayer,[noSandLayer,sandLayer]).	% senseSandLayer if the slayers is sandLayer or noSandLayer
prim_action(senseIceLayer,[noIceLayer,iceLayer]).	% senseSandLayer if the ilayers is sandLayer or noSandLayer


prim_fluent(finished).							% indicates finished
prim_fluent(slayers).							% sandLayer or noSandLayer
prim_fluent(ilayers).							% iceLayer or noIceLayer
prim_fluent(layers).							% unknown bound on the number of chops


poss(senseSandLayer,true).						% PRECONDITION: senseSandLayer always true, causes loop
poss(senseIceLayer,true).						% PRECONDITION: senseIceLayer always true, causes loop
poss(removeIceLayer,ilayers=iceLayer).			% PRECONDITION: iceLayer before removeIceLayer
poss(removeSandLayer,slayers=sandLayer).		% PRECONDITION: sandLayer before removeSandLayer
poss(putAwayMineral,and(ilayers=noIceLayer,slayers=noSandLayer)).	% PRECONDITION: noIceLayer and noSandLayer before putAwayMineral


causes(putAwayMineral,finished,yes,true).		% causes finished to be yes

causes(removeSandLayer,layers,X,X is layers-1).
causes(removeSandLayer,slayers,noSandLayer,true).
causes(removeSandLayer,slayers,sandLayer,true).

causes(removeIceLayer,layers,X,X is layers-1).
causes(removeIceLayer,ilayers,noIceLayer,true).
causes(removeIceLayer,ilayers,iceLayer,true).


settles(senseSandLayer,X,slayers,X,true).
rejects(senseSandLayer,noSandLayer,layers,0,true).	% if noSandLayer, layers cannot be 0, still iceLayer
rejects(senseSandLayer,sandLayer,layers,0,true).	% if sandLayer, layers cannot be 0, still sandLayer

settles(senseIceLayer,X,ilayers,X,true).
rejects(senseIceLayer,noIceLayer,layers,0,true).
rejects(senseIceLayer,iceLayer,layers,0,true).


init(ilayers,iceLayer).							% the ilayers may be iceLayer initially
init(ilayers,noIceLayer).						% the ilayers may be noIceLayer initially

init(slayers,sandLayer).						% the slayers may be sandLayer initially
init(slayers,noSandLayer).						% the slayers may be noSandLayer  initially


parm_fluent(layers).							% layers is the unique parameter
init_parm(generate,layers,1).					% small bound for generating is 1
init_parm(test,layers,10).						% large bound for testing is 10



top :- kplan(finished=yes).
