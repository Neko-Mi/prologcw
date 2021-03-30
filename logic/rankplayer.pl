

rankplayer:-
    consult("util.pl"),
    consult("data/teams.pl"),
    consult("data/events.pl"),
    consult("data/achivments.pl"),
    consult("data/matches.pl"),
    consult("data/players.pl"),
    playersrerank,
    saveplayer,
    consult("main.pl").


playersrerank:-
    allplayers(T),
    forallplayers(T),
    playerrerank1.

foroneplayer(T):-
    allscoreplayer(T),
    playerrerank1.

forallplayers([]):-!.
forallplayers([N | T]):-
    allscoreplayer(N),
    forallplayers(T).

playerrerank1:-
    allplayersscores(T),
    sortplayers(T, NT),
    rerankallplayers(NT, 1).


allplayers(T):-
    findall(Z, playersname(Z), T).

playersname(N):-
    player(N, _, _, _).

allscoreplayer(T):-
    player(T, N, _, OR),
    formrankplayer(T, FS),
    retract(player(T, N, _, OR)),
    assert(player(T, N, FS, OR)).


allplayersscores(T):-
    findall(Z, players1(Z), T).

players1([N, T, S]):-
    player(N, T, S, _).
    

moveminendp([], []):-!.
moveminendp([H], [H]):-!.
moveminendp([[N, Team, S], [N1, Team1, S1] | T], [[N, Team, S] | LWME]):-
    S >= S1, !,
    moveminendp([[N1, Team1, S1] | T], LWME).
moveminendp([[N, Team, S], [N1, Team1, S1] | T], [[N1, Team1, S1] | LWME]):-
    moveminendp([[N, Team, S] | T], LWME).

sortplayers(SL, SL):-
    moveminendp(SL, DSL),
    SL = DSL, 
    !.
sortplayers(L, SL):-
    moveminendp(L, SP),
    sortplayers(SP, SL).


rerankallplayers([], _):-!.
rerankallplayers([[N, Team, S] | T], I):-
    retract(player(N, Team, S, _)),
    assert(player(N, Team, S, I)),
    NI is I + 1,
    rerankallplayers(T, NI).


checkdateevent2(_, _, Y, R):-
    date1(_,_, X),
    Y < X - 1,
    !,
    R is 0.
checkdateevent2(_, M, Y, R):-
    date1(_, M1, Y1),
    Y < Y1,
    M =< M1,
    % MR = 0,
    !,
    R is 0.
checkdateevent2(_, M, _, R):-
    date1(_, M1, _),
    MR is M - M1,
    MR > 0, MR < 5,
    !,
    R is 0.
checkdateevent2(_, M, Y, R):-
    date1(_, M1, Y1),
    MR is M - M1,
    MR = 0, Y = Y1,
    !,
    R is 0.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 6, D > D1 ;
    MR = 7, D < D1),
    !,
    R is 0.05.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 7, D > D1 ;
    MR = 8, D < D1),
    !,
    R is 0.25.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 8, D > D1 ;
    MR = 9, D < D1),
    !,
    R is 0.4.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 9, D > D1 ;
    MR = 10, D < D1),
    !,
    R is 0.55.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 10, D > D1 ;
    MR = 11, D < D1),
    !,
    R is 0.7.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 11, D > D1 ;
    MR = 0),
    !,
    R is 1.
checkdateevent2(_, M, _, R):-
    date1(_, M1, _),
    MR is M - M1,
    MR = 0, 
    !,
    R is 1.
checkdateevent2(_, M, _, R):-
    date1(_, M1, _),
    MR is M - M1,
    MR < 0, MR < -6,
    !,
    R is 0.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -6, D1 < D ;
    MR = -5, D1 > D),
    !,
    R is 0.05.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -5, D1 < D ;
    MR = -4, D1 > D),
    !,
    R is 0.25.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -4, D1 < D ;
    MR = -3, D1 > D),
    !,
    R is 0.4.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -3, D1 < D ;
    MR = -2, D1 > D),
    !,
    R is 0.55.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -2, D1 < D ;
    MR = -1, D1 > D),
    !,
    R is 0.7.
checkdateevent2(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -1, D > D1;
    MR = 0),
    !,
    R is 1.
checkdateevent2(_, _, _, 0):-!.







% form rankplayer ------------------------------------------------------------
formrankplayer(T, Score):-
    allmatchesplayer1(T, A),
    % player(T, _, F, _),
    scorematchesplayer(A, S),
    checkscoreformplayer(S, Score).

checkscoreformplayer(S, 0):-
    S < 1,
    !.
checkscoreformplayer(S, 1000):-
    S > 1000,
    !.
checkscoreformplayer(S, S):-!.


allmatchesplayer1(T, A):-
    findall(Z, matchesplayer1(Z, T), A).

matchesplayer1([O, S, D, M, Y], T):-
    match(_, _, T, S, _, _, _, _, _, _, _, _, O, _, _, _, _, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, _, _, _, T, S, _, _, _, _, _, _, O, _, _, _, _, _, _, _,  _, _, _, _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, _, _, _, _, _, T, S, _, _, _, _, O, _, _, _, _, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, _, _, _, _, _, _, _, T, S, _, _, O, _, _, _, _, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, _, _, _, _, _, _, _, _, _, T, S, O, _, _, _, _, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, _, T, S, _, _, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, _, _, _, T, S, _, _, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, T, S, _,  _, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, T,  S, _, _,  _, _, D, M, Y).
matchesplayer1([O, S, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,  _, T, S,  _, _, D, M, Y).


scorematchesplayer([], 0):- !.
scorematchesplayer([], _):-!.
scorematchesplayer([[O, ST, D, M, Y] | Tail],  S):-
    scorematchesplayer(Tail, S1),
    team(O, _, _, _, ORank),
    checkdateevent2(D, M, Y, Rate),
    checkrankopp(ORank, Score),
    X is round(Rate * ST),
    F is round(X * Score),
    S is S1 + F.





checkrankopp(R, S):-
    R =< 5,
    !,
    S is 1.
checkrankopp(R, S):-
    R < 10,
    !,
    S is 0.75.
checkrankopp(R, S):-
    R < 20,
    !,
    S is 0.5.
checkrankopp(R, S):-
    R < 30,
    !,
    S is 0.25.
checkrankopp(R, S):-
    R >= 30,
    !,
    S is 0.1.




:-rankplayer.
