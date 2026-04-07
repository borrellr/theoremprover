%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combined reasoning example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% derive that in myR, plus(x,0) = x, and show equational proof

prove_ring_add_identity(R, X,
    combined(LogicProof, EqProof)) :-
    % from is_ring(R) and implications, infer forall(X, eq(plus(X,0), X))
    infer(is_ring(R), LogicProof1),
    infer(forall(X0, eq(plus(X0,0), X0)), LogicProof2),
    LogicProof = and(LogicProof1, LogicProof2),

    % instantiate at concrete X
    substitute(X0, X, eq(plus(X0,0), X0), EqFormula),
    EqFormula = eq(plus(X,0), X),

    % now run equational prover on plus(X,0) = X
    eq_prove(plus(X,0), X, EqProof).
