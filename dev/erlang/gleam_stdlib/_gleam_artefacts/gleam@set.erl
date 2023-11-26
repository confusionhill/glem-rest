-module(gleam@set).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([new/0, size/1, insert/2, contains/2, delete/2, to_list/1, from_list/1, fold/3, filter/2, drop/2, take/2, union/2, intersection/2]).
-export_type([set/1]).

-opaque set(DQA) :: {set, gleam@map:map_(DQA, list(nil))}.

-spec new() -> set(any()).
new() ->
    {set, gleam@map:new()}.

-spec size(set(any())) -> integer().
size(Set) ->
    gleam@map:size(erlang:element(2, Set)).

-spec insert(set(DQG), DQG) -> set(DQG).
insert(Set, Member) ->
    {set, gleam@map:insert(erlang:element(2, Set), Member, [])}.

-spec contains(set(DQJ), DQJ) -> boolean().
contains(Set, Member) ->
    _pipe = erlang:element(2, Set),
    _pipe@1 = gleam@map:get(_pipe, Member),
    gleam@result:is_ok(_pipe@1).

-spec delete(set(DQL), DQL) -> set(DQL).
delete(Set, Member) ->
    {set, gleam@map:delete(erlang:element(2, Set), Member)}.

-spec to_list(set(DQO)) -> list(DQO).
to_list(Set) ->
    gleam@map:keys(erlang:element(2, Set)).

-spec from_list(list(DQR)) -> set(DQR).
from_list(Members) ->
    Map = gleam@list:fold(
        Members,
        gleam@map:new(),
        fun(M, K) -> gleam@map:insert(M, K, []) end
    ),
    {set, Map}.

-spec fold(set(DQU), DQW, fun((DQW, DQU) -> DQW)) -> DQW.
fold(Set, Initial, Reducer) ->
    gleam@map:fold(
        erlang:element(2, Set),
        Initial,
        fun(A, K, _) -> Reducer(A, K) end
    ).

-spec filter(set(DQX), fun((DQX) -> boolean())) -> set(DQX).
filter(Set, Predicate) ->
    {set,
        gleam@map:filter(erlang:element(2, Set), fun(M, _) -> Predicate(M) end)}.

-spec drop(set(DRA), list(DRA)) -> set(DRA).
drop(Set, Disallowed) ->
    gleam@list:fold(Disallowed, Set, fun delete/2).

-spec take(set(DRE), list(DRE)) -> set(DRE).
take(Set, Desired) ->
    {set, gleam@map:take(erlang:element(2, Set), Desired)}.

-spec order(set(DRI), set(DRI)) -> {set(DRI), set(DRI)}.
order(First, Second) ->
    case gleam@map:size(erlang:element(2, First)) > gleam@map:size(
        erlang:element(2, Second)
    ) of
        true ->
            {First, Second};

        false ->
            {Second, First}
    end.

-spec union(set(DRN), set(DRN)) -> set(DRN).
union(First, Second) ->
    {Larger, Smaller} = order(First, Second),
    fold(Smaller, Larger, fun insert/2).

-spec intersection(set(DRR), set(DRR)) -> set(DRR).
intersection(First, Second) ->
    {Larger, Smaller} = order(First, Second),
    take(Larger, to_list(Smaller)).
