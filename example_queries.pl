% 1. Pure algebra: x + 0 = x
?- eq_prove(plus(x,0), x, Proof).
% Proof = proof(eq(plus(x,0),x), x, x, StepsA, StepsB).

% 2. Modus Ponens chain: from p, p->q, q->r infer r
?- infer(r, Proof).
% Proof is a nested mp(...) tree.

% 3. Universal instantiation: from forall(x, plus(x,0)=x) infer plus(a,0)=a
?- infer(eq(plus(a,0), a), Proof).
% Proof = ui(...).

% 4. Resolution: derive contradiction (false) from clauses
?- infer(false, Proof).
% Proof = resolution(C1, C2, []).

% 5. Combined: ring property + algebraic simplification
?- prove_ring_add_identity(myR, x, CombinedProof).
