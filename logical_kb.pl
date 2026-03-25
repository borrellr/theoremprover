%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logical KB: facts and implications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Example predicates:
%   is_ring(R)
%   has_additive_identity(R)
%   eq_axiom(R, forall(X, eq(plus(X,0), X)))

fact(is_ring(myR)).

implies(is_ring(R), has_additive_identity(R)).
implies(has_additive_identity(R),
        forall(X, eq(plus(X,0), X))).

% Some propositional facts
fact(p).
implies(p, q).
implies(q, r).

% For resolution, we store clauses as lists of literals
% e.g., [p, not(q), r]
clause([p, not(q)]).
clause([not(p), r]).
