-module(simple_app).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([main/0]).

-spec main() -> nil.
main() ->
    gleam@io:println(<<"Hello from simple_app!"/utf8>>).
