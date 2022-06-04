%%%-------------------------------------------------------------------
%% @doc liam public API
%% @end
%%%-------------------------------------------------------------------

-module(liam_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    liam_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
