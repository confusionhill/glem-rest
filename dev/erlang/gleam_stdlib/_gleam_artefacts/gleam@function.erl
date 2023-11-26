-module(gleam@function).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([compose/2, curry2/1, curry3/1, curry4/1, curry5/1, curry6/1, flip/1, identity/1, constant/1, tap/2, apply1/2, apply2/3, apply3/4]).

-spec compose(fun((DIC) -> DID), fun((DID) -> DIE)) -> fun((DIC) -> DIE).
compose(Fun1, Fun2) ->
    fun(A) -> Fun2(Fun1(A)) end.

-spec curry2(fun((DIF, DIG) -> DIH)) -> fun((DIF) -> fun((DIG) -> DIH)).
curry2(Fun) ->
    fun(A) -> fun(B) -> Fun(A, B) end end.

-spec curry3(fun((DIJ, DIK, DIL) -> DIM)) -> fun((DIJ) -> fun((DIK) -> fun((DIL) -> DIM))).
curry3(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> Fun(A, B, C) end end end.

-spec curry4(fun((DIO, DIP, DIQ, DIR) -> DIS)) -> fun((DIO) -> fun((DIP) -> fun((DIQ) -> fun((DIR) -> DIS)))).
curry4(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> fun(D) -> Fun(A, B, C, D) end end end end.

-spec curry5(fun((DIU, DIV, DIW, DIX, DIY) -> DIZ)) -> fun((DIU) -> fun((DIV) -> fun((DIW) -> fun((DIX) -> fun((DIY) -> DIZ))))).
curry5(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) -> fun(D) -> fun(E) -> Fun(A, B, C, D, E) end end end
        end
    end.

-spec curry6(fun((DJB, DJC, DJD, DJE, DJF, DJG) -> DJH)) -> fun((DJB) -> fun((DJC) -> fun((DJD) -> fun((DJE) -> fun((DJF) -> fun((DJG) -> DJH)))))).
curry6(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) ->
                fun(D) -> fun(E) -> fun(F) -> Fun(A, B, C, D, E, F) end end end
            end
        end
    end.

-spec flip(fun((DJJ, DJK) -> DJL)) -> fun((DJK, DJJ) -> DJL).
flip(Fun) ->
    fun(B, A) -> Fun(A, B) end.

-spec identity(DJM) -> DJM.
identity(X) ->
    X.

-spec constant(DJN) -> fun((any()) -> DJN).
constant(Value) ->
    fun(_) -> Value end.

-spec tap(DJP, fun((DJP) -> any())) -> DJP.
tap(Arg, Effect) ->
    Effect(Arg),
    Arg.

-spec apply1(fun((DJR) -> DJS), DJR) -> DJS.
apply1(Fun, Arg1) ->
    Fun(Arg1).

-spec apply2(fun((DJT, DJU) -> DJV), DJT, DJU) -> DJV.
apply2(Fun, Arg1, Arg2) ->
    Fun(Arg1, Arg2).

-spec apply3(fun((DJW, DJX, DJY) -> DJZ), DJW, DJX, DJY) -> DJZ.
apply3(Fun, Arg1, Arg2, Arg3) ->
    Fun(Arg1, Arg2, Arg3).
