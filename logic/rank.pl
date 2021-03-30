
rank:-
    consult("util.pl"),
    consult("data/teams.pl"),
    consult("data/events.pl"),
    consult("data/achivments.pl"),
    consult("data/matches.pl"),
    teamsrerank,
    saveteam,
    consult("main.pl").



teamsrerank:-
    allteams(T),
    forallteams(T),
    teamrerank1.

foroneteam(T):-
    allscore(T),
    teamrerank1.

forallteams([]):-!.
forallteams([N | T]):-
    allscore(N),
    forallteams(T).

teamrerank1:-
    allteamsscores(T),
    sortteams(T, NT),
    rerankall(NT, 1).


allteams(T):-
    findall(Z, teamsname(Z), T).

teamsname(N):-
    team(N, _, _, _, _).

allscore(T):-
    team(T, _, _, _, OR),
    achivmentrank(T, AS),
    formrank(T, FS),
    lanrank(T, LS),
    retract(team(T, _, _, _, _)),
    assert(team(T, AS, FS, LS, OR)).


allteamsscores(T):-
    findall(Z, teams1(Z), T).

teams1([N, A, F, L]):-
    team(N, A, F, L, _).
    

moveminend([], []):-!.
moveminend([H], [H]):-!.
moveminend([[N, A, F, L], [N1, A1, F1, L1] | T], [[N, A, F, L] | LWME]):-
    S is A + F + L,
    S1 is A1 + F1 + L1,
    S >= S1, !,
    moveminend([[N1, A1, F1, L1] | T], LWME).
moveminend([[N, A, F, L], [N1, A1, F1, L1] | T], [[N1, A1, F1, L1] | LWME]):-
    moveminend([[N, A, F, L] | T], LWME).

sortteams(SL, SL):-
    moveminend(SL, DSL),
    SL = DSL, 
    !.
sortteams(L, SL):-
    moveminend(L, SP),
    sortteams(SP, SL).


rerankall([], _):-!.
rerankall([[N, A, F, L] | T], I):-
    retract(team(N, A, F, L, _)),
    assert(team(N, A, F, L, I)),
    NI is I + 1,
    rerankall(T, NI).



% achivment rank ------------------------------------------------------
achivmentrank(T, Score):-
    allachivs(T, A),
    writeln(T),
    writeln(A),
    scoreevents(A, S),
    checkscoreachiv(S, Score).

checkscoreachiv(S, Score):-
    S < 1,
    !,
    Score is 0.
checkscoreachiv(S, Score):-
    S > 500,
    !,
    Score is 500.
checkscoreachiv(S, S):-!.
 












checkdateeventyear(_, _, Y, R):-
    date1(_,_, X),
    Y < X - 1,
    !,
    R is 0.
checkdateeventyear(_, M, Y, 0):-
    date1(_, M1, Y1),
    Y < Y1,
    M < M1,
    !.
checkdateeventyear(D, M, Y, R):-
    date1(D1, M1, Y1),
    Y < Y1,
    M = M1,
    D =< D1,
    !,
    R is 0.
checkdateeventyear(D, M, Y, R):-
    date1(D1, M1, Y1),
    Y < Y1,
    M = M1,
    D > D1,
    !,
    R is 0.1.
checkdateeventyear(D, M, Y, R):-
    date1(D1, M1, Y1),
    MR is M - M1,
    Y = Y1, MR = 0, D > D1,
    !,
    R is 1.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 1, D < D1 ;
    MR = -11, D < D1),
    !,
    R is 0.01.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 1, D > D1 ;
    MR = -11, D > D1),
    !,
    R is 0.05.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 1, D < D1 ;
    MR = -11, D < D1),
    !,
    R is 0.01.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 1, D > D1 ;
    MR = -11, D > D1),
    !,
    R is 0.05.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 2, D < D1 ;
    MR = -10, D < D1),
    !,
    R is 0.05.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 2, D > D1 ;
    MR = -10, D > D1),
    !,
    R is 0.1.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 3, D < D1 ;
    MR = -9, D < D1),
    !,
    R is 0.1.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 3, D > D1 ;
    MR = -9, D > D1),
    !,
    R is 0.2.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 4, D < D1 ;
    MR = -8, D < D1),
    !,
    R is 0.2.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 4, D > D1 ;
    MR = -8, D > D1),
    !,
    R is 0.3.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 5, D < D1 ;
    MR = -7, D < D1),
    !,
    R is 0.3.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 5, D > D1 ;
    MR = -7, D > D1),
    !,
    R is 0.4.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 6, D < D1 ;
    MR = -6, D < D1),
    !,
    R is 0.4.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 6, D > D1 ;
    MR = -6, D > D1),
    !,
    R is 0.5.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 7, D < D1 ;
    MR = -5, D < D1),
    !,
    R is 0.5.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 7, D > D1 ;
    MR = -5, D > D1),
    !,
    R is 0.6.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 8, D < D1 ;
    MR = -4, D < D1),
    !,
    R is 0.6.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 8, D > D1 ;
    MR = -4, D > D1),
    !,
    R is 0.7.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 9, D < D1 ;
    MR = -3, D < D1),
    !,
    R is 0.7.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 9, D > D1 ;
    MR = -3, D > D1),
    !,
    R is 0.8.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 10, D < D1 ;
    MR = -2, D < D1),
    !,
    R is 0.8.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 10, D > D1 ;
    MR = -2, D > D1),
    !,
    R is 0.9.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 11, D < D1 ;
    MR = -1, D < D1),
    !,
    R is 0.9.
checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 11, D > D1 ;
    MR = -1, D > D1),
    !,
    R is 0.95.

checkdateeventyear(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -1, D > D1 ;
    MR = 0, D < D1),
    !,
    R is 1.

checkdateeventyear(_, _, _, 0):-!.










































checkdateevent3(_, _, Y, R):-
    date1(_,_, X),
    X1 is X - 1,
    Y < X1,
    !,
    R is 0.
checkdateevent3(_, M, Y, R):-
    date1(_, M1, Y1),
    Y < Y1,
    M < M1,
    !,
    R is 0.
checkdateevent3(_, M, Y, R):-
    date1(_, M1, Y1),
    Y < Y1,
    M = M1,
    !,
    R is 0.
checkdateevent3(_, M, _, R):-
    date1(_, M1, _),
    MR is M - M1,
    MR > 0, MR < 9,
    !,
    R is 0.
checkdateevent3(_, M, Y, R):-
    date1(_, M1, Y1),
    M = M1, Y = Y1,
    !,
    R is 1.
checkdateevent3(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 10, D > D1 ;
    MR = 11, D < D1),
    !,
    R is 0.75.
checkdateevent3(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = 11, D > D1 ;
    MR = 0),
    !,
    R is 1.
checkdateevent3(_, M, _, R):-
    date1(_, M1, _),
    MR is M - M1,
    MR < 0, MR < -2,
    !,
    R is 0.
checkdateevent3(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -2, D > D1 ;
    MR = -1, D1 > D),
    !,
    R is 0.75.
checkdateevent3(D, M, _, R):-
    date1(D1, M1, _),
    MR is M - M1,
    (MR = -1, D > D1 ;
    MR = 0),
    !,
    R is 1.
checkdateevent3(_, _, _, 0):-!.








scoreevents([], 0):- !.
scoreevents([], _):- !.
scoreevents([[N, R] | Tail], S):-
    scoreevents(Tail, S1),
    event(_, N, T, _, _, _, D, M, Y),
    checkdateeventyear(D, M, Y, Rate),
    tierpoint(T, Score),
    placerate(R, Place),
    X is round(Rate * Score),
    F is round(X * Place),
    S is S1 + F.

allachivs(T, A):-
    findall(Z, achivments1(Z, T), A).

achivments1([N, P], T):-
    achivment(N, P, T, _, _, _, _, _).









% lan rank --------------------------------------------------------------
lanrank(T, Score):-
    allachivs(T, A),
    scoreevents1(A, S),
    checkscorelan(S, Score).

checkscorelan(S, Score):-
    S < 1,
    !,
    Score is 0.
checkscorelan(S, Score):-
    S > 300,
    !,
    Score is 300.
checkscorelan(S, S):-!.

scoreevents1([], 0):- !.
scoreevents1([], _):- !.
scoreevents1([[N, R] | Tail], S):-
    scoreevents1(Tail, S1),
    event(_, N, T, _, _, _, D, M, Y),
    checkdateevent3(D, M, Y, Rate),
    tierpoint(T, Score),
    placerate(R, Place),
    X is round(Rate * Score),
    F is round(X * Place),
    S is S1 + F.


















% form rank ------------------------------------------------------------
formrank(T, Score):-
    allmatches1(T, A),
    team(T, _, _, _, TRank),
    scorematches1(A, TRank, S),
    % writeln(S),
    checkscoreform(S, Score).

checkscoreform(S, 0):-
    S < 1,
    !.
checkscoreform(S, 200):-
    S > 200,
    !.
checkscoreform(S, S):-!.


allmatches1(T, A):-
    findall(Z, matches1(Z, T), A).

matches1([O, ST, SO, D, M, Y], T):-
    match(_, T, _, _, _, _, _, _, _, _, _, _, O, _, _, _, _, _, _, _, _, _, _, ST, SO, D, M, Y).
matches1([O, ST, SO, D, M, Y], T):-
    match(_, O, _, _, _, _, _, _, _, _, _, _, T, _, _, _, _, _, _, _, _, _, _, SO, ST, D, M, Y).

scorematches1([], _,  0):- !.
scorematches1([], _,  _):-!.
scorematches1([[O, ST, SO, D, M, Y] | Tail], TRank,  S):-
    scorematches1(Tail, TRank,  S1),
    team(O, _, _, _, ORank),
    checkdateevent3(D, M, Y, Rate),
    RM is TRank - ORank,
    SM is ST - SO,
    checkrank(RM, SM, Score),
    X is Score * ST,
    S is S1 + round(Rate * X).


checkrank(RM, SM, S):-
    SM = 1,
    !,
    checkrankwin(RM, S).
checkrank(RM, SM, S * 2):-
    SM = 2,
    !,
    checkrankwin(RM, S).
checkrank(_, SM, 1):-
    SM < 0.

checkrankwin(R, S):-
    R =< -20,
    !,
    S is 3.
checkrankwin(R, S):-
    R < -5,
    !,
    S is 10.
checkrankwin(R, S):-
    R < 5,
    !,
    S is 20.
checkrankwin(R, S):-
    R < 20,
    !,
    S is 25.
checkrankwin(R, S):-
    R >= 20,
    !,
    S is 30.



:-rank.
