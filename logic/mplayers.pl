mplayers:-
    consult("util.pl"),
    consult("data/players.pl").

% mplayersmenu:-
%     nl,
%     writeln("Izmenenie dannih igrokov"),
%     write("0 - vihod v glavnoe menu"), nl,
%     write("1 - Add"), nl,
%     write("2 - Delete"), nl,
%     write("3 - Change"), nl,
%     nl,
%     write("Vvedite nomer: "),
%     readln(A),
%     convertToNumber(A, R),
%     findmplayers(R),
%     mplayersmenu.

% findmplayers(R):-
%     R = 0,
%     !,
%     consult("main.pl").
% findmplayers(R):-
%     R = 1,
%     !,
%     addplayer.
% findmplayers(R):-
%     R = 2,
%     !,
%     deleteplayer.
% findmplayers(R):-
%     R = 3,
%     !,
%     changeplayer.
% findmplayers(_):-
%     mplayersmenu.

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

% deleteplayersteam(N):-
%     findplayersdel(N, P),
%     deleteteaminpl(P, N),
%     saveplayer.

% findplayersdel(T, P):-
%     findall(Z, playerst(Z, T), P).

% playerst([N, S, R], T):-
%     player(N, T, S, R).

% deleteteaminpl([], _):-!.
% deleteteaminpl([[N, S, R] | Tail], T):-
%     retract(player(N, T, S, R)),
%     asserta(player(N, _, S, R)),
%     deleteteaminpl(Tail, T).

% changeplayer:-
%     deleteplayer,
%     addplayer.

playername(E):-
    nl,
    write("Vvedite nickname: "),
    readln(A),
    atomic_list_concat(A, " ", R),
    checkstring(R, E),
    writeln(E).

% playerteam(E):-
%     nl,
%     write("Vvedite nazvanie komandi: "),
%     readln(A),
%     atomic_list_concat(A, " ", E),
%     writeln(E).



:-mplayers.