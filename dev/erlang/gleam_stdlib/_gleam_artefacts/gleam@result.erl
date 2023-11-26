-module(gleam@result).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([is_ok/1, is_error/1, map/2, map_error/2, flatten/1, 'try'/2, then/2, unwrap/2, lazy_unwrap/2, unwrap_error/2, unwrap_both/1, nil_error/1, 'or'/2, lazy_or/2, all/1, partition/1, replace/2, replace_error/2, values/1, try_recover/2]).

-spec is_ok({ok, any()} | {error, any()}) -> boolean().
is_ok(Result) ->
    case Result of
        {error, _} ->
            false;

        {ok, _} ->
            true
    end.

-spec is_error({ok, any()} | {error, any()}) -> boolean().
is_error(Result) ->
    case Result of
        {ok, _} ->
            false;

        {error, _} ->
            true
    end.

-spec map({ok, BFU} | {error, BFV}, fun((BFU) -> BFY)) -> {ok, BFY} |
    {error, BFV}.
map(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, Fun(X)};

        {error, E} ->
            {error, E}
    end.

-spec map_error({ok, BGB} | {error, BGC}, fun((BGC) -> BGF)) -> {ok, BGB} |
    {error, BGF}.
map_error(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, Error} ->
            {error, Fun(Error)}
    end.

-spec flatten({ok, {ok, BGI} | {error, BGJ}} | {error, BGJ}) -> {ok, BGI} |
    {error, BGJ}.
flatten(Result) ->
    case Result of
        {ok, X} ->
            X;

        {error, Error} ->
            {error, Error}
    end.

-spec 'try'({ok, BGQ} | {error, BGR}, fun((BGQ) -> {ok, BGU} | {error, BGR})) -> {ok,
        BGU} |
    {error, BGR}.
'try'(Result, Fun) ->
    case Result of
        {ok, X} ->
            Fun(X);

        {error, E} ->
            {error, E}
    end.

-spec then({ok, BGZ} | {error, BHA}, fun((BGZ) -> {ok, BHD} | {error, BHA})) -> {ok,
        BHD} |
    {error, BHA}.
then(Result, Fun) ->
    'try'(Result, Fun).

-spec unwrap({ok, BHI} | {error, any()}, BHI) -> BHI.
unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default
    end.

-spec lazy_unwrap({ok, BHM} | {error, any()}, fun(() -> BHM)) -> BHM.
lazy_unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default()
    end.

-spec unwrap_error({ok, any()} | {error, BHR}, BHR) -> BHR.
unwrap_error(Result, Default) ->
    case Result of
        {ok, _} ->
            Default;

        {error, E} ->
            E
    end.

-spec unwrap_both({ok, BHU} | {error, BHU}) -> BHU.
unwrap_both(Result) ->
    case Result of
        {ok, A} ->
            A;

        {error, A@1} ->
            A@1
    end.

-spec nil_error({ok, BHX} | {error, any()}) -> {ok, BHX} | {error, nil}.
nil_error(Result) ->
    map_error(Result, fun(_) -> nil end).

-spec 'or'({ok, BID} | {error, BIE}, {ok, BID} | {error, BIE}) -> {ok, BID} |
    {error, BIE}.
'or'(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second
    end.

-spec lazy_or({ok, BIL} | {error, BIM}, fun(() -> {ok, BIL} | {error, BIM})) -> {ok,
        BIL} |
    {error, BIM}.
lazy_or(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second()
    end.

-spec all(list({ok, BIT} | {error, BIU})) -> {ok, list(BIT)} | {error, BIU}.
all(Results) ->
    gleam@list:try_map(Results, fun(X) -> X end).

-spec do_partition(list({ok, BJI} | {error, BJJ}), list(BJI), list(BJJ)) -> {list(BJI),
    list(BJJ)}.
do_partition(Results, Oks, Errors) ->
    case Results of
        [] ->
            {Oks, Errors};

        [{ok, A} | Rest] ->
            do_partition(Rest, [A | Oks], Errors);

        [{error, E} | Rest@1] ->
            do_partition(Rest@1, Oks, [E | Errors])
    end.

-spec partition(list({ok, BJB} | {error, BJC})) -> {list(BJB), list(BJC)}.
partition(Results) ->
    do_partition(Results, [], []).

-spec replace({ok, any()} | {error, BJR}, BJU) -> {ok, BJU} | {error, BJR}.
replace(Result, Value) ->
    case Result of
        {ok, _} ->
            {ok, Value};

        {error, Error} ->
            {error, Error}
    end.

-spec replace_error({ok, BJX} | {error, any()}, BKB) -> {ok, BJX} | {error, BKB}.
replace_error(Result, Error) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, _} ->
            {error, Error}
    end.

-spec values(list({ok, BKE} | {error, any()})) -> list(BKE).
values(Results) ->
    gleam@list:filter_map(Results, fun(R) -> R end).

-spec try_recover(
    {ok, BKK} | {error, BKL},
    fun((BKL) -> {ok, BKK} | {error, BKO})
) -> {ok, BKK} | {error, BKO}.
try_recover(Result, Fun) ->
    case Result of
        {ok, Value} ->
            {ok, Value};

        {error, Error} ->
            Fun(Error)
    end.
