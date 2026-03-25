%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logical inference: Modus Ponens, Modus Tollens, UI, Resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% infer(Formula, ProofTree)

% Base: known fact
infer(F, fact(F)) :-
    fact(F).

% Modus Ponens: from P and (P -> Q) infer Q
infer(Q, mp(PProof, ImpProof)) :-
    implies(P, Q),
    infer(P, PProof),
    infer(implies(P,Q), ImpProof).

infer(implies(P,Q), fact(implies(P,Q))) :-
    implies(P,Q).

% Modus Tollens: from ¬Q and (P -> Q) infer ¬P
infer(not(P), mt(NotQProof, ImpProof)) :-
    implies(P, Q),
    infer(not(Q), NotQProof),
    infer(implies(P,Q), ImpProof).

% Negated facts (for demo)
fact(not(s)).  % example

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universal Instantiation: from forall(X, P(X)) infer P(c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

infer(Instantiated, ui(ForallProof, X, C)) :-
    infer(forall(X, P), ForallProof),
    substitute(X, C, P, Instantiated).

% Simple forall facts
fact(forall(x, eq(plus(x,0), x))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resolution (very small, propositional-style)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% resolve two clauses to get a resolvent
resolve_clause(C1, C2, Resolvent) :-
    select(Lit, C1, Rest1),
    complementary(Lit, Lit2),
    select(Lit2, C2, Rest2),
    append(Rest1, Rest2, Tmp),
    sort(Tmp, Resolvent).

complementary(not(A), A).
complementary(A, not(A)).

% resolution proof: derive empty clause (contradiction)
infer(false, resolution(C1, C2, Resolvent)) :-
    clause(C1),
    clause(C2),
    resolve_clause(C1, C2, Resolvent),
    Resolvent = [].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Substitution for UI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

substitute(X, C, Var, C) :-
    Var == X, !.
substitute(_, _, Var, Var) :-
    var(Var), !.
substitute(X, C, plus(A,B), plus(A1,B1)) :-
    substitute(X, C, A, A1),
    substitute(X, C, B, B1).
substitute(X, C, times(A,B), times(A1,B1)) :-
    substitute(X, C, A, A1),
    substitute(X, C, B, B1).
substitute(X, C, eq(A,B), eq(A1,B1)) :-
    substitute(X, C, A, A1),
    substitute(X, C, B, B1).
substitute(X, C, pred(Name,Args), pred(Name,Args1)) :-
    maplist(substitute(X,C), Args, Args1).
substitute(_, _, T, T).
