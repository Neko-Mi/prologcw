levents:-
    consult("data/events.pl"),
    consult("util.pl"),
    nl,
    writeln("        Events"),
    writeln("Number, Tier, Name, Start date - End date"),
    showallevents,
    eventsmenu.


eventsmenu:-
    nl,
    write("0 - vihod v glavnoe menu"), nl,
    write("Vvedite nomer eventa: "),
    readln(A),
    convertToNumber(A, R),
    findevents(R).

findevents(R):-
    R = 0,
    !,
    consult("main.pl").
findevents(R):-
    event(R, N, _, _, _, _, _, _, _),
    nl,
    writeln(N),
    consult("data/achivments.pl"),
    writeln("Place, Team"),
    findachivs1(N),
    vihod.

findachivs1(N):-
    findall(Z, achivs1(Z, N), S),
    sortteamsach(S, T),
    showachivs(T, 10),
    nl.


achivs1([R, T], N):-
    achivment(N, R, T, _, _, _, _, _).

moveminup23([], []):-!.
moveminup23([H], [H]):-!.
moveminup23([[S, T], [S1, T1] | Tail], [[S, T] | LWME]):-
    S =< S1, !,
    moveminup23([[S1, T1] | Tail], LWME).
moveminup23([[S, T], [S1, T1] | Tail], [[S1, T1] | LWME]):-
    moveminup23([[S, T] | Tail], LWME).

sortteamsach(SL, SL):-
    moveminup23(SL, DSL),
    SL = DSL, 
    !.
sortteamsach(L, SL):-
    moveminup23(L, SP),
    sortteamsach(SP, SL).

:-levents.