%Parte 1 

k_period(S, K, Result) :-atom_chars(S, Lista), accumulator(Lista, K, CharLists), converter(CharLists, Result).

accumulator(Lista, K, Result) :- findall(Sub, sublist(Lista, K, Sub), Result).

sublist(List, K, Sub) :- append(Sub, _, List), length(Sub, K).
sublist([_|Tail], K, Sub) :- sublist(Tail, K, Sub).

%Parte 2

ocurrencias(S, Result):- atom_chars(S, Lista), takeSubstrings(Lista, 1, Result).

takeSubstrings(Lista, K, Result) :- length(Lista, N), K =< N, findSubstrings(Lista, K, Subs), length(Subs, M), checkIntegerDivision(N, M, D), repeatSubstring(Subs, D, R), checkEquality(Lista, R), Result = D, !.
takeSubstrings(Lista, K, Result) :- length(Lista, N), K =< N, K1 is K + 1, takeSubstrings(Lista, K1, Result).

findSubstrings(_, 0, []).
findSubstrings([X|XS], K, [X|Result]):- K > 0, length([X|XS], N), N >= K, K1 is K - 1, findSubstrings(XS, K1, Result).

checkIntegerDivision(A, B, D):- 0 is A mod B, D is A // B.

repeatSubstring(_, 0, []).
repeatSubstring(Subs, N, Result):- N > 0, N1 is N - 1, repeatSubstring(Subs, N1, Temp), append(Subs, Temp, Result).

checkEquality([], []).
checkEquality([X|XS], [Y|YS]):- X == Y, checkEquality(XS, YS).

%Parte 3
%Idea de implementacion:
%Recibimos el string y lo convertimos a una lista de códigos ASCII. Invertimos la lista de ASCII. Invertimos cada elemento.
%Unificamos los elementos invertidos en un string y retornamos.

action(0, S, Result):- decode(S, Result).
action(1, S, Result):- encode(S, Result).

encode(S, EncodedString):- atom_codes(S, C), reverse(C, R), maplist(invertASCII, R, ASCIIList), atomics_to_string(ASCIIList, EncodedString).

invertNumber(N, Invertido) :-
    number_codes(N, Codigos),
    reverse(Codigos, CodigosInvertidos),
    number_codes(Invertido, CodigosInvertidos).

invertASCII(Codigo, CodigoInvertido) :-
    invertNumber(Codigo, CodigoInvertido).
