%%%-------------------------------------------------------------------
%% @doc erlang1 public API
%% @end
%%%-------------------------------------------------------------------

-module(erlang1_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    lager:start(),
    lager:set_loglevel(lager_console_backend, debug),
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", cowboy_static, {priv_file, erlang1, "index.html"} },            
            {"/websocket", websocket_handler, []},
            {"/[...]", cowboy_static, {priv_dir, erlang1, ""} }
        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    erlang1_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(my_http_listener).

%% internal functions
