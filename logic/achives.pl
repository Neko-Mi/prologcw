win/1.
:-dynamic win/1.

achives:-
    consult("util.pl"),
    consult("data/matches.pl"),
    consult("data/events.pl"),
    consult("data/achivments.pl"),
    consult("data/players.pl"),
    showallachives1,
    rankachivesmenu,
    consult("main.pl").


saveachives:-
    tell('data/achivments.pl'),
    listing(achivment),
    told,
    writeln("File izmenen").

calachivs(E):-
    findalleventmatches(E, M),
    length(M, N),
    N < 3,
    !,
    writeln("Ne dostato4no matchey"),
    nl,
    vihod.
calachivs(E):-
    findalleventmatches(E, M),
    resultmatch(M),
    length(M, F),
    findallwiners(T),
    removeduplicates(T, NT),
    findallwinersplayers(NT, P),
    applyachiv(NT, P, E, F).


removeduplicates([], []):-!.
removeduplicates([X|Xs], Ys):-
      member(X, Xs),
      !, 
      removeduplicates(Xs, Ys).
removeduplicates([X|Xs], [X|Ys]):-
      !, 
      removeduplicates(Xs, Ys).

findalleventmatches(E, M):-
    findall(Z, evmatches(Z, E), M).

evmatches([T1, S1, T2, S2], E):-
    match(E, T1, _, _, _, _, _, _, _, _, _, _, T2, _, _, _, _, _, _, _, _, _, _, S1, S2, _, _, _).


resultmatch([]):-!.
resultmatch([[T1, S1, _, S2] | Tail]):-
    R is S1 - S2,
    R > 0,
    !,
    assert(win(T1)),
    resultmatch(Tail).
resultmatch([[_, _, T2, _] | Tail]):-
    assert(win(T2)),
    resultmatch(Tail).

findallwiners(T):-
    findall(Z, wins(Z), T).

findallwinersplayers([], []):-!.
findallwinersplayers([T | Tail], [P | Tail1]):-
    findall(Z, players12(Z, T), P),
    findallwinersplayers(Tail, Tail1).


applyachiv([], [], _, _):-!.
applyachiv([T | Tail], [[P1, P2, P3, P4, P5] | Tail1], E, F):-
    findall(T, win(T), W),
    length(W, N),
    eventplace(N, F, P),
    assert(achivment(E, P, T, P1, P2, P3, P4, P5)),
    applyachiv(Tail, Tail1, E, F).



players12(P, T):-
    player(P, T, _, _).

wins(T):-
    win(T).
    
eventplace(N, F, 1):-
    N = 3, F = 7, !.
eventplace(N, F, 2):-
    N = 2, F = 7, !.
eventplace(N, F, 3):-
    N = 1, F = 7, !.
eventplace(N, F, 1):-
    N = 2, F = 3, !.
eventplace(N, F, 2):-
    N = 1, F = 3, !.



rankachivesmenu:-
    nl,
    write("0 - vihod v glavnoe menu"), nl,
    write("Vvedite nomer eventa: "),
    readln(A),
    convertToNumber(A, R),
    findachivets(R).

findachivets(R):-
    R = 0,
    !,
    consult("main.pl").
findachivets(R):-
    event(R, N, _, _, _, _, _, _, _),
    nl,
    writeln(N),
    calachivs(N),
    saveachives.



:-achives.