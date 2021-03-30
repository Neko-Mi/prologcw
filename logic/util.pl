date1(1,5,2020).
% время для расчета: 4 мая 2020

tierpoint(1, 400).
tierpoint(2, 200).
tierpoint(3, 100).
tierpoint(4, 50).
tierpoint(5, 10).

placerate(1, 1).
placerate(2, 0.6).
placerate(3, 0.3).
placerate(4, 0.3).

month(1, 31).
month(2, 28).
month(3, 31).
month(4, 30).
month(5, 31).
month(6, 30).
month(7, 31).
month(8, 31).
month(9, 30).
month(10, 31).
month(11, 30).
month(12, 31).



convertToText([A | _], R):-
    atom_string(A, R).

convertToNumber([A | _], A).

checkstring(R, E):-
    (atom(R) ; string(R)),
    !,
    atom_string(R, E).
checkstring(E, E).

vihod:-
    write("0 - vihod v glavnoe menu"), nl,
    readln(A),
    convertToNumber(A, R),
    R = 0,
    consult("main.pl").
vihod:-
    readln(A),
    convertToNumber(A, R),
    R \= 0,
    vihod.

showmatches([], _):- !.
showmatches([_], N):- 
    N = 0,
    !.
showmatches([[H, H1, H2, H3, H4, H5, H6, H7 | _] | T], N):-
    Y is N - 1,
    write(H),
    write(", "),
    write(H1),
    write(" - "),
    write(H2),
    write(", "),
    write(H3),
    write(":"),
    write(H4),
    write(", "),
    write(H5),
    write("."),
    write(H6),
    write("."),
    write(H7),
    nl,
    showmatches(T, Y).

showachivs([], _):- !.
showachivs([_], N):-
    N = 0,
    !.
showachivs([[H, H1 | _] | T], N):-
    Y is N - 1,
    write(H),
    write(" - "),
    write(H1),
    nl,
    showachivs(T, Y).

saveplayer:-
    tell('data/players.pl'),
    listing(player),
    told,
    writeln("File izmenen").

saveteam:-
    tell('data/teams.pl'),
    listing(team),
    told,
    writeln("File izmenen").

savematch:-
    tell('data/matches.pl'),
    listing(match),
    told,
    writeln("File izmenen").

showallevents:-
    findall(Z, events(Z), S),
    showevents(S),
    nl.

events([A, C, B, D, E, F, G, H, I]):-
    event(A, B, C, D, E, F, G, H, I).

showevents([]):- !.
showevents([[H, H1, H2, H3, H4, H5, H6, H7, H8 | _] | T]):-
    write(H),
    write(" - "),
    write(H1),
    write(", "),
    write(H2),
    write(", "),
    write(H3),
    write("."),
    write(H4),
    write("."),
    write(H5),
    write(" - "),
    write(H6),
    write("."),
    write(H7),
    write("."),
    write(H8),
    nl,
    showevents(T).


showall:-
    findall(Z, teams(Z), S),
    showteams(S),
    nl.

teams([R, N, A, F, L]):-
    team(N, A, F, L, R).
teams([N, A, F, L], R):-
    team(N, A, F, L, R).

showteams([]):- !.
showteams([[H, H1, H2, H3, H4 | _] | T]):-
    write(H),
    write(", "),
    write(H1),
    write(", "),
    write(H2),
    write(", "),
    write(H3),
    write(", "),
    write(H4),
    nl,
    showteams(T).









showallachives1:-
    nl,
    findall(Z, events2(Z), S),
    eventcheckachiv(S, S2),
    checkzeroevent(S2).


checkzeroevent([]):-
    writeln('Net ne raschitanih eventov'),!.
checkzeroevent(S2):-
    showeventsac1(S2).


events2([I, E]):-
    event(I, E, _, _, _, _, _, _, _).


eventcheckachiv([], []):-!.
eventcheckachiv([[H1, H2] | Tail], [[H1, H2] | Tail1]):-
    findall(X, achivs2(X, H2), S),
    length(S, N),
    N < 1,
    !,
    eventcheckachiv(Tail, Tail1).
eventcheckachiv([[_, _] | Tail], H):-
    eventcheckachiv(Tail, H).

achivs2(X, E):-
    achivment(E, X, _, _, _, _, _, _).


showeventsac1([]):- !.
showeventsac1([[H, H1  | _] | T]):-
    write(H),
    write(" - "),
    write(H1),
    nl,
    showeventsac1(T).