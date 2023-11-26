-module(gleam@function).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([compose/2, curry2/1, curry3/1, curry4/1, curry5/1, curry6/1, flip/1, identity/1, constant/1, tap/2, apply1/2, apply2/3, apply3/4]).

-spec compose(fun((EVP) -> EVQ), fun((EVQ) -> EVR)) -> fun((EVP) -> EVR).
compose(Fun1, Fun2) ->
    fun(A) -> Fun2(Fun1(A)) end.

-spec curry2(fun((EVS, EVT) -> EVU)) -> fun((EVS) -> fun((EVT) -> EVU)).
curry2(Fun) ->
    fun(A) -> fun(B) -> Fun(A, B) end end.

-spec curry3(fun((EVW, EVX, EVY) -> EVZ)) -> fun((EVW) -> fun((EVX) -> fun((EVY) -> EVZ))).
curry3(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> Fun(A, B, C) end end end.

-spec curry4(fun((EWB, EWC, EWD, EWE) -> EWF)) -> fun((EWB) -> fun((EWC) -> fun((EWD) -> fun((EWE) -> EWF)))).
curry4(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> fun(D) -> Fun(A, B, C, D) end end end end.

-spec curry5(fun((EWH, EWI, EWJ, EWK, EWL) -> EWM)) -> fun((EWH) -> fun((EWI) -> fun((EWJ) -> fun((EWK) -> fun((EWL) -> EWM))))).
curry5(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) -> fun(D) -> fun(E) -> Fun(A, B, C, D, E) end end end
        end
    end.

-spec curry6(fun((EWO, EWP, EWQ, EWR, EWS, EWT) -> EWU)) -> fun((EWO) -> fun((EWP) -> fun((EWQ) -> fun((EWR) -> fun((EWS) -> fun((EWT) -> EWU)))))).
curry6(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) ->
                fun(D) -> fun(E) -> fun(F) -> Fun(A, B, C, D, E, F) end end end
            end
        end
    end.

-spec flip(fun((EWW, EWX) -> EWY)) -> fun((EWX, EWW) -> EWY).
flip(Fun) ->
    fun(B, A) -> Fun(A, B) end.

-spec identity(EWZ) -> EWZ.
identity(X) ->
    X.

-spec constant(EXA) -> fun((any()) -> EXA).
constant(Value) ->
    fun(_) -> Value end.

-spec tap(EXC, fun((EXC) -> any())) -> EXC.
tap(Arg, Effect) ->
    Effect(Arg),
    Arg.

-spec apply1(fun((EXE) -> EXF), EXE) -> EXF.
apply1(Fun, Arg1) ->
    Fun(Arg1).

-spec apply2(fun((EXG, EXH) -> EXI), EXG, EXH) -> EXI.
apply2(Fun, Arg1, Arg2) ->
    Fun(Arg1, Arg2).

-spec apply3(fun((EXJ, EXK, EXL) -> EXM), EXJ, EXK, EXL) -> EXM.
apply3(Fun, Arg1, Arg2, Arg3) ->
    Fun(Arg1, Arg2, Arg3).
