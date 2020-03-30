-module(hello_handler).

-behaviour(cowboy_handler).
-compile([{parse_transform, lager_transform}]).
-export([init/2]).

init(Req0, State) ->
    lager:info("init ~p",[Req0]),
    {ok, Req} = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        <<"Hello Erlang!">>,
        Req0),
    {ok, Req, State}.
