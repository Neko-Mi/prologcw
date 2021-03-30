
mmatches:-
    consult("util.pl"),
    consult("data/matches.pl"),
    consult("data/events.pl"),
    consult("data/teams.pl"),
    consult("data/players.pl"),
    consult("data/achivments.pl"),
    mmatchesmenu.


mmatchesmenu:-
    nl,
    writeln("Izmenenie dannih matchey"),
    write("0 - vihod v glavnoe menu"), nl,
    write("1 - Add"), nl,
    write("2 - Delete"), nl,
    write("3 - Change"), nl,
    nl,
    write("Vvedite nomer: "),
    readln(A),
    convertToNumber(A, R),
    findmmatches(R),
    mmatchesmenu.

findmmatches(R):-
    R = 0,
    !,
    consult("main.pl").
findmmatches(R):-
    R = 1,
    !,
    addmatch.
findmmatches(R):-
    R = 2,
    !,
    deletematch.
findmmatches(R):-
    R = 3,
    !,
    changematch.
findmmatches(_):-
    mmatchesmenu.


addmatch:-
    eventsmenumatch(E),
    writeln(E),
    teamsmenumatch(T1),
    teamsmenumatch(T2),
    matchscore1(T1, ST1),
    matchscore1(T2, ST2),
    event(_, E, _, D, M, Y, _, _, _),
    matchplayers(T1, N1, N2, N3, N4, N5, S1, S2, S3, S4, S5),
    matchplayers(T2, N6, N7, N8, N9, N10, S6, S7, S8, S9, S10),
    asserta(match(E, T1, N1, S1, N2, S2, N3, S3, N4, S4, N5, S5, T2, N6, S6, N7, S7, N8, S8, N9, S9, N10, S10, ST1, ST2, D, M, Y)),
    savematch.

deletematch:-
    eventname1(E),
    teamsname(T1),
    teamsname(T2),
    matchscore1(T1, S1),
    matchscore2(T2, S2),
    event(E, _, _, D, M, Y, _, _, _),
    retract(match(E, T1, _, _, _, _, _, _, _, _, _, _, T2, _, _, _, _, _, _, _, _, _, _, S1, S2, D, M, Y)),
    savematch.

changematch:-
    deletematch,
    addmatch.

teamplayers(T, P):-
    findall(Z, teplayers(Z, T), P).

teplayers(P, T):-
    player(P, T, _, _).

allteamplayers([P1, P2, P3, P4, P5], P1, P2, P3, P4, P5):-!.

matchplayers(T, N1, N2, N3, N4, N5, S1, S2, S3, S4, S5):-
    teamplayers(T, P),
    allteamplayers(P, N1, N2, N3, N4, N5),
    matchscoreplayer(S1),
    matchscoreplayer(S2),
    matchscoreplayer(S3),
    matchscoreplayer(S4),
    matchscoreplayer(S5).




matchscoreplayer(E):-
    random(0, 500, E).

    

matchscore1(T, E):-
    nl,
    write("Vvedite score "),
    write(T),
    write(": "),
    readln(A),
    convertToNumber(A, E).


% matchday(E):-
%     event(R, N, _, D, M, _, _, _, _),
%     readln(A),
%     convertToNumber(A, D).

% matchmonth(E):-
%     nl,
%     write("Vvedite mesyac: "),
%     readln(A),
%     convertToNumber(A, E).

% matchyear(E):-
%     nl,
%     write("Vvedite god: "),
%     readln(A),
%     convertToNumber(A, E).


eventname1(E):-
    nl,
    write("Vvedite nazvanie eventa: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).

teamsname(E):-
    nl,
    write("Vvedite nazvanie eventa: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).




eventsmenumatch(E):-
    writeln("Number, Tier, Name, Start date - End date"),
    showallachives1,
    nl,
    write("0 - vihod v glavnoe menu"), nl,
    write("Vvedite nomer eventa: "),
    readln(A),
    convertToNumber(A, R),
    findevents2(R, E).

findevents2(R, _):-
    R = 0,
    !,
    consult("main.pl").
findevents2(R, N):-
    event(R, N, _, _, _, _, _, _, _),
    nl.

teamsmenumatch(T):-
    showall,
    nl,
    write("0 - vihod v glavnoe menu"), nl,
    write("Vvedite nomer komandi: "),
    readln(A),
    convertToNumber(A, R),
    writeln(R),
    findteamsmatch(R, T).

findteamsmatch(R, _):-
    R = 0,
    !,
    consult("main.pl").
findteamsmatch(R, N):-
    team(N, _, _, _, R),
    nl,
    !.
findteamsmatch(_, _):-
    writeln('Net takoy komandi'),
    vihod.



:-mmatches.