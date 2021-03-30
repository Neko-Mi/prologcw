mteams:-
    consult("util.pl"),
    consult("data/teams.pl"),
    consult("mplayers.pl"),
    mteamsmenu.


mteamsmenu:-
    nl,
    writeln("Izmenenie dannih komand"),
    write("0 - vihod v glavnoe menu"), nl,
    write("1 - Add"), nl,
    write("2 - Delete"), nl,
    write("3 - Change"), nl,
    nl,
    write("Vvedite nomer: "),
    readln(A),
    convertToNumber(A, R),
    findmteams(R),
    mteamsmenu.

findmteams(R):-
    R = 0,
    !,
    consult("main.pl").
findmteams(R):-
    R = 1,
    !,
    addteam.
findmteams(R):-
    R = 2,
    !,
    deleteteam.
findmteams(R):-
    R = 3,
    !,
    changeteam.
findmteams(_):-
    mteamsmenu.


addteam:-
    teamname(N),
    % teamr(R),
    asserta(team(N, 0, 0, 0, 999)),
    addplayersinteam(N),
    saveteam.

% teamr(E):-
%     team(_, _, _, _, X),
%     E is X - 2.

deleteteam:-
    teamname(N),
    retract(team(N, _, _, _, _)),
    deleteplayersteam(N),
    saveteam.

changeteam:-
    deleteteam,
    addteam.

teamname(E):-
    nl,
    write("Vvedite nazvanie: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).




:-mteams.