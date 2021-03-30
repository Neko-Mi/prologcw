lplayers:-
    consult("util.pl"),
    consult("data/players.pl"),
    nl,
    writeln("        Players"),
    writeln("Rank, Nickname, Team"),
    allplayers,
    vihod.


allplayers:-
    findall(Z, players(Z), S),
    showplayers1(S),
    nl.

players([R, NN, T]):-
    player(NN, T, _, R).

showplayers1([]):- !.
showplayers1([[H, H1, H2 | _] | T]):-
    write(H),
    write(", "),
    write(H1),
    write(", "),
    write(H2),
    nl,
    showplayers1(T).


:-lplayers.