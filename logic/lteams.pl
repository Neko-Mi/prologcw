lteams:-
    consult("util.pl"),
    consult("data/teams.pl"),
    nl,
    write("        Teams"),nl,
    write("Rank, Name, Achivs, Form, Lan"),nl,
    showall,
    teamsmenu.
    


teamsmenu:-
    nl,
    write("0 - vihod v glavnoe menu"), nl,
    write("Vvedite nomer komandi: "),
    readln(A),
    convertToNumber(A, R),
    findteams(R).

% Vivod team
findteams(R):-
    R = 0,
    !,
    consult("main.pl").
findteams(R):-
    team(N, _, _, _, R),
    nl,
    writeln(N),
    consult("data/players.pl"),
    consult("data/achivments.pl"),
    consult("data/matches.pl"),
    writeln("Rank, Nickname"),
    findplayers(N),
    writeln("Place, Event"),
    findachivs(N),
    writeln("Event, Team1, Team2, Score"),
    findmatches(N),
    vihod.
findteams(_):-
    teamsmenu.

% Vivod players
findplayers(N):-
    findall(Z, playerslteam(Z, N), S),
    showplayers(S),
    nl.

playerslteam([R, NN], N):-
    player(NN, N, _, R).

showplayers([]):- !.
showplayers([[H, H1 | _] | T]):-
    write(H),
    write(", "),
    write(H1),
    nl,
    showplayers(T).


% Vivod achivments
findachivs(N):-
    findall(Z, achivs(Z, N), S),
    showachivs(S, 10),
    nl.

achivs([R, N], T):-
    achivment(N, R, T, _, _, _, _, _).


% Vivod matches
findmatches(N):-
    findall(Z, matches(Z, N), S),
    showmatches(S, 10),
    nl.

matches([E, N, O, S1, S2, D1, D2, D3], N):-
    match(E, N, _, _, _, _, _, _, _, _, _, _, O, _, _, _, _, _, _, _, _, _, _, S1, S2, D1, D2, D3).
matches([E, O, N, S1, S2, D1, D2, D3], N):-
    match(E, O, _, _, _, _, _, _, _, _, _, _, N, _, _, _, _, _, _, _, _, _, _, S1, S2, D1, D2, D3).



:-lteams.