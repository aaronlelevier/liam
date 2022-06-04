%%%-------------------------------------------------------------------
%%% @author Aaron Lelevier
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(liam_boto3_server).
-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
  code_change/3]).

%% Macros
-define(SERVER, ?MODULE).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% Spawning and gen_server implementation
%%%===================================================================

%% Initializes the Flask App
init([]) ->
  % dir where the flask app lives
  Dir = os:getenv(
    "LIAM_BOTO3_FLASK_DIR",
    filename:join(os:getenv("HOME"), "Documents/github/boto3_flask")
  ),

  % start Flask app command
  Cmd = string:join(
    [
      "export FLASK_APP=app",
      lists:flatten(io_lib:format("~s/venv/bin/python ~s/liam.py", [Dir, Dir]))
    ],
    " && "
  ),
  erlang:spawn(os, cmd, [Cmd]),
  {ok, #{}}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  erlang:spawn(os, cmd, ["lsof -i :5000 | awk 'NR > 1 {print $2}' | xargs kill"]),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
