lmatches:-
    consult("util.pl"),
    consult("data/matches.pl"),
    nl,
    writeln("        Matches"),
    writeln("Event, Team1, Team2, Score"),
    allmatches,
    vihod.

allmatches:-
    findall(Z, matches(Z), S),
    showmatches(S, 10),
    nl.

matches([E, N, O, S1, S2, D1, D2, D3]):-
    match(E, N, _, _, _, _, _, _, _, _, _, _, O, _, _, _, _, _, _, _, _, _, _, S1, S2, D1, D2, D3).



:-lmatches.