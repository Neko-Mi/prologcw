main:-
    consult("logic/util.pl"),
    nl,
    write("       Menu"), nl,
    writeln("Prosmotr dannih: "),
    write("1 - Teams"), nl,
    write("2 - Players"), nl,
    write("3 - Matches"), nl,
    write("4 - Events"), nl,
    writeln("Izmenenie dannih: "),
    write("5 - Teams"), nl,
    write("6 - Matches"), nl,
    write("7 - Events"), nl,
    write("8 - Rerank teams"), nl,
    write("9 - Rerank players"), nl,
    writeln("10 - Ras4et Achivments"),
    nl,
    poisk.


poisk:-
    write("Vvedite nomer razdela: "),
    readln(A),
    convertToText(A, R),
    find(R).

find(A):-
    A = "1",
    !,
    consult("logic/lteams.pl").
find(A):-
    A = "2",
    !,
    consult("logic/lplayers.pl").
find(A):-
    A = "3",
    !,
    consult("logic/lmatches.pl").
find(A):-
    A = "4",
    !,
    consult("logic/levents.pl").
find(A):-
    A = "5",
    !,
    consult("logic/mteams.pl").
find(A):-
    A = "6",
    !,
    consult("logic/mmatches.pl").
find(A):-
    A = "7",
    !,
    consult("logic/mevents.pl").
find(A):-
    A = "8",
    !,
    consult("logic/rank.pl").
find(A):-
    A = "9",
    !,
    consult("logic/rankplayer.pl").
find(R):-
    R = "10",
    !,
    consult("logic/achives.pl").
find(A):-
    write(A),
    writeln(" - net razdela c takim nomerom"),
    poisk.

:-main.