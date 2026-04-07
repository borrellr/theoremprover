%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equational reasoning with trace (proof tree)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% eq_prove(E1, E2, ProofTree)
% ProofTree is a list of steps: step(ExprBefore, ExprAfter, RuleName)

eq_prove(A, B, proof(eq(A,B), NA, NB, StepsA, StepsB)) :-
    normalize_with_steps(A, NA, [], StepsA),
    normalize_with_steps(B, NB, [], StepsB),
    NA = NB.

normalize_with_steps(Expr, Normal, Acc, Steps) :-
    rewrite_once_labeled(Expr, Expr1, RuleName), !,
    append(Acc, [step(Expr, Expr1, RuleName)], Acc1),
    normalize_with_steps(Expr1, Normal, Acc1, Steps).
normalize_with_steps(Expr, Expr, Steps, Steps).

% labeled rewrite_once
rewrite_once_labeled(Expr, ExprOut, RuleName) :-
    rewrite_rule_name(Expr, ExprOut, RuleName).
rewrite_once_labeled(plus(A,B), plus(A1,B), RuleName) :-
    rewrite_once_labeled(A, A1, RuleName).
rewrite_once_labeled(plus(A,B), plus(A,B1), RuleName) :-
    rewrite_once_labeled(B, B1, RuleName).
rewrite_once_labeled(times(A,B), times(A1,B), RuleName) :-
    rewrite_once_labeled(A, A1, RuleName).
rewrite_once_labeled(times(A,B), times(A,B1), RuleName) :-
    rewrite_once_labeled(B, B1, RuleName).

% name each rewrite rule
rewrite_rule_name(plus(X,Y), plus(Y,X), comm_plus) :- rewrite(plus(X,Y), plus(Y,X)).
rewrite_rule_name(times(X,Y), times(Y,X), comm_times) :- rewrite(times(X,Y), times(Y,X)).
rewrite_rule_name(plus(plus(X,Y),Z), plus(X,plus(Y,Z)), assoc_plus1) :- rewrite(plus(plus(X,Y),Z), plus(X,plus(Y,Z))).
rewrite_rule_name(plus(X,plus(Y,Z)), plus(plus(X,Y),Z), assoc_plus2) :- rewrite(plus(X,plus(Y,Z)), plus(plus(X,Y),Z)).
rewrite_rule_name(times(times(X,Y),Z), times(X,times(Y,Z)), assoc_times1) :- rewrite(times(times(X,Y),Z), times(X,times(Y,Z))).
rewrite_rule_name(times(X,times(Y,Z)), times(times(X,Y),Z), assoc_times2) :- rewrite(times(X,times(Y,Z)), times(times(X,Y),Z)).
rewrite_rule_name(plus(X,0), X, add_id1) :- rewrite(plus(X,0), X).
rewrite_rule_name(plus(0,X), X, add_id2) :- rewrite(plus(0,X), X).
rewrite_rule_name(times(X,1), X, mul_id1) :- rewrite(times(X,1), X).
rewrite_rule_name(times(1,X), X, mul_id2) :- rewrite(times(1,X), X).
rewrite_rule_name(times(X, plus(Y,Z)), plus(times(X,Y), times(X,Z)), distr1) :-
    rewrite(times(X, plus(Y,Z)), plus(times(X,Y), times(X,Z))).
rewrite_rule_name(times(plus(Y,Z), X), plus(times(Y,X), times(Z,X)), distr2) :-
    rewrite(times(plus(Y,Z), X), plus(times(Y,X), times(Z,X))).
rewrite_rule_name(plus(X, neg(X)), 0, add_inv1) :- rewrite(plus(X, neg(X)), 0).
rewrite_rule_name(plus(neg(X), X), 0, add_inv2) :- rewrite(plus(neg(X), X), 0).
