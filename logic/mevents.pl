mevents:-
    consult("util.pl"),
    consult("data/events.pl"),
    meventsmenu.


meventsmenu:-
    nl,
    writeln("Izmenenie dannih eventa"),
    write("0 - vihod v glavnoe menu"), nl,
    write("1 - Add"), nl,
    write("2 - Delete"), nl,
    write("3 - Change"), nl,
    nl,
    write("Vvedite nomer: "),
    readln(A),
    convertToNumber(A, R),
    findmevents(R),
    meventsmenu.

findmevents(R):-
    R = 0,
    !,
    consult("main.pl").
findmevents(R):-
    R = 1,
    !,
    addevent.
findmevents(R):-
    R = 2,
    !,
    deleteevent.
findmevents(R):-
    R = 3,
    !,
    changeevent.
findmevents(_):-
    meventsmenu.


addevent:-
    eventname(N),
    eventtier(T),
    eventday(D),
    eventmonth(M),
    eventyear(Y),
    eventday1(D1),
    eventmonth1(M1),
    eventyear1(Y1),
    eventid(I),
    asserta(event(I,N, T, D, M, Y, D1, M1, Y1)),
    saveevent.

deleteevent:-
    eventname(N),
    retract(event(_,N, _, _, _, _, _, _, _)),
    saveevent.

changeevent:-
    deleteevent,
    addevent.

eventname(E):-
    nl,
    write("Vvedite nazvanie eventa: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).

eventtier(E):-
    nl,
    write("Vvedite uroven eventa: "),
    readln(A),
    convertToNumber(A, E).

eventday(E):-
    nl,
    write("Vvedite den` nachala: "),
    readln(A),
    convertToNumber(A, E).

eventmonth(E):-
    nl,
    write("Vvedite mesyac nachala: "),
    readln(A),
    convertToNumber(A, E).

eventyear(E):-
    nl,
    write("Vvedite god nachala: "),
    readln(A),
    convertToNumber(A, E).

eventday1(E):-
    nl,
    write("Vvedite den` konca: "),
    readln(A),
    convertToNumber(A, E).

eventmonth1(E):-
    nl,
    write("Vvedite mesyac konca: "),
    readln(A),
    convertToNumber(A, E).

eventyear1(E):-
    nl,
    write("Vvedite god konca: "),
    readln(A),
    convertToNumber(A, E).

eventid(E):-
    event(X, _,_,_,_,_,_,_,_),
    E is X + 1.

saveevent:-
    tell('data/events.pl'),
    listing(event),
    told,
    writeln("File izmenen").

:-mevents.