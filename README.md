erlang cowboy websocket
=====

An OTP application, to show how to implement a basic websocket using cowboy and erlang, lager added to show messaged on console, rebar3 needed to comiple and generate release, more info in https://www.rebar3.org/

Build
-----

    $ rebar3 compile
    $ rebar3 release
    $ rebar3 _build/default/rel/prod/bin/prod console
    
Point your web browser to http://localhost:8080/

Websocket on http://localhost:8080/websocket
