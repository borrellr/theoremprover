%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algebraic axioms (rewrite rules)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rewrite(plus(X,Y), plus(Y,X)).                          % commutativity +
rewrite(times(X,Y), times(Y,X)).                        % commutativity *

rewrite(plus(plus(X,Y),Z), plus(X,plus(Y,Z))).          % associativity +
rewrite(plus(X,plus(Y,Z)), plus(plus(X,Y),Z)).

rewrite(times(times(X,Y),Z), times(X,times(Y,Z))).      % associativity *
rewrite(times(X,times(Y,Z)), times(times(X,Y),Z)).

rewrite(plus(X,0), X).                                  % additive identity
rewrite(plus(0,X), X).

rewrite(times(X,1), X).                                 % multiplicative identity
rewrite(times(1,X), X).

rewrite(times(X, plus(Y,Z)),                            % distributivity
        plus(times(X,Y), times(X,Z))).
rewrite(times(plus(Y,Z), X),
        plus(times(Y,X), times(Z,X))).

rewrite(plus(X, neg(X)), 0).                            % additive inverse
rewrite(plus(neg(X), X), 0).
