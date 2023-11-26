-module(gleeunit@should).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([equal/2, not_equal/2, be_ok/1, be_error/1, be_true/1, be_false/1, fail/0]).

-spec equal(FEK, FEK) -> nil.
equal(A, B) ->
    gleeunit_ffi:should_equal(A, B).

-spec not_equal(FEL, FEL) -> nil.
not_equal(A, B) ->
    gleeunit_ffi:should_not_equal(A, B).

-spec be_ok({ok, FEM} | {error, any()}) -> FEM.
be_ok(A) ->
    gleeunit_ffi:should_be_ok(A).

-spec be_error({ok, any()} | {error, FER}) -> FER.
be_error(A) ->
    gleeunit_ffi:should_be_error(A).

-spec be_true(boolean()) -> nil.
be_true(Actual) ->
    _pipe = Actual,
    gleeunit_ffi:should_equal(_pipe, true).

-spec be_false(boolean()) -> nil.
be_false(Actual) ->
    _pipe = Actual,
    gleeunit_ffi:should_equal(_pipe, false).

-spec fail() -> nil.
fail() ->
    be_true(false).
