mplayers:-
    consult("util.pl"),
    consult("data/players.pl").


addplayersinteam(T):-
    addplayer(T),
    addplayer(T),
    addplayer(T),
    addplayer(T),
    addplayer(T).

addplayer(T):-
    playername(N),
    checholdscore(N, W),
    oldscore(W, S, R),
    asserta(player(N, T, S, R)),
    saveplayer.

checholdscore(N, W):-
    findall(Z, players13(Z, N), W),
    length(W, L),
    L > 0,
    !,
    delplayer(N, W).
checholdscore(_, [0, 0]):-!.

delplayer(P, [[S, R]]):-
    retract(player(P, _, S, R)).

oldscore([[S, R]], S, R):-!.
oldscore([S, R], S, R):-!.

players13([S, R], N):-
    player(N, _, S, R).



playername(E):-
    nl,
    write("Vvedite nickname: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).


:-mplayers.