%% CSCI3180 Principles of Programming Languages
%% --- Declaration ---
%% I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
%% breaches of such policy and regulations, as contained in the website
%% http://www.cuhk.edu.hk/policy/academichonesty/
%% Assignment 4
%% Name: 
%% Student ID: 
%% Email Addr: 

sum(0, X, X).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).

product(0, _, 0).
product(s(X), Y, A) :- product(X, Y, Z), sum(Z, Y, A).

%% 1b) compute the product of 3 and 4.
%% ?- product(s(s(s(0))), s(s(s(s(0)))), X).

%% 1c) compute the result of 8 divided by 4.
%% ?- product(X, s(s(s(s(0)))), s(s(s(s(s(s(s(s(0))))))))).

%% 1d) the query to find the factors of 6.
%% ?- product(X, Y, s(s(s(s(s(s(0)))))))

exp(_, 0, s(0)).
exp(0, _, 0).
exp(X, s(Y), Z) :- exp(X, Y, A), product(A, X, Z).

%% 1f) the query to compute 2^3
%% ?- exp(s(s(0)), s(s(s(0))), X).

%% 1g) the query to compute log2 8.
%% ?- exp(s(s(0)), X, s(s(s(s(s(s(s(s(0))))))))).



transition(a, 0, c).
transition(a, 1, a).
transition(b, 0, c).
transition(b, 1, a).
transition(c, 0, c).
transition(c, 1, b).

state(N) :- transition(N, _, _).

walk([], B, B).
walk([S|T], B, E) :- transition(B, S, D), walk(T, D, E).

%% 2c)  Define a Prolog relation walk(S,B,E), which is true if we can go from state B to state E with input sequence S in the form of a list.
%% ?- walk([0,1,1,1,1], c, a).
%% true.
