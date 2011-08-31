-module({{pluginid}}).
-author("{{author}}").

-behaviour(gen_server).

-include("{{pluginid}}.hrl").

-export([start_link/2]).
% gen_server callbacks
-export([
  init/1, 
  handle_call/3, 
  handle_cast/2, 
  handle_info/2, 
  terminate/2, 
  code_change/3
]).

-record(state, { config }).

start_link(_Name, Config) ->   
  gen_server:start_link(?MODULE, [Config], []).
  
init([Config]) ->
	{ok, #state{ config=Config }}.
	
handle_call(Msg, _From, State=#state{ config=_Config }) ->
	rabbit_log:warning(" Unkown call: ~p~n State: ~p~n", [Msg, State]),
	{noreply, State}.

handle_cast(Msg, State=#state{ config=_Config }) ->
	rabbit_log:warning(" Unkown cast: ~p~n State: ~p~n", [Msg, State]),
	{noreply, State}.

handle_info(Msg, State) ->
	rabbit_log:warning(" Unkown message: ~p~n State: ~p~n", [Msg, State]),
	{noreply, State}.

terminate(_, #state{ config=_Config }) -> 
	rabbit_log:info("Terminating ~p~n", [self()]),
	ok.

code_change(_OldVsn, State, _Extra) -> 
	{ok, State}.
