-module(websocket_handler).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).
-compile([{parse_transform, lager_transform}]).

init(Req, Opts) ->
	Headers = maps:get(headers, Req),
	Key = maps:get(<<"sec-websocket-key">>, Headers),
	lager:info("init with key :~s", [Key]),
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
	lager:info("websocket init [~s]", [State] ),
	erlang:start_timer(1000, self(), <<"Hello!">>),
	{[], State}.

websocket_handle({text, Msg}, State) ->
	lager:info("websocket handler [~s]", [State]),
	{[{text, << "Message from websocket_handler :", Msg/binary >>}], State};
websocket_handle(_Data, State) ->
	{[], State}.

websocket_info({timeout, _Ref, Msg}, State) ->
	lager:info("socket info [~s][~s]", [Msg, State]),
	erlang:start_timer(1000, self(), <<"this is info every 1 sec">>),
	{[{text, Msg}], State};
websocket_info(_Info, State) ->
	{[], State}.