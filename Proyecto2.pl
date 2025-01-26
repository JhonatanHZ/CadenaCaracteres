%Parte 1 

k_period(S, K, Result) :-atom_chars(S, Lista), accumulator(Lista, K, CharLists), converter(CharLists, Result).

accumulator(Lista, K, Result) :- findall(Sub, sublist(Lista, K, Sub), Result).

sublist(List, K, Sub) :- append(Sub, _, List), length(Sub, K).
sublist([_|Tail], K, Sub) :- sublist(Tail, K, Sub).

converter([], []).
converter([H|T], [HString|TString]) :- string_chars(HString, H), converter(T, TString).


%Parte 2

ocurrencias(S, Result):- atom_chars(S, Lista), takeSubstrings(Lista, 1, Result).

takeSubstrings(Lista, K, Result):- length(Lista, N),
    (K =< N, findSubstrings(Lista, K, Subs), length(Subs, M), checkIntegerDivision(N, M, D), repeatSubstring(Subs, D, R), checkEquality(Lista, R) -> Result = D;   
        K1 is K + 1, takeSubstrings(Lista, K1, Result)).

findSubstrings(_, 0, []).
findSubstrings([X|XS], K, [X|Result]):- K > 0, length([X|XS], N), N >= K, K1 is K - 1, findSubstrings(XS, K1, Result).

checkIntegerDivision(A, B, D):- 0 is A mod B, D is A // B.

repeatSubstring(_, 0, []).
repeatSubstring(Subs, N, Result):- N > 0, N1 is N - 1, repeatSubstring(Subs, N1, Temp), append(Subs, Temp, Result).

checkEquality([], []).
checkEquality([X|XS], [Y|YS]):- X == Y, checkEquality(XS, YS).