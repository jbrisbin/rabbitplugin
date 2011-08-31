%%% -------------------------------------------------------------------
%%% Author  : {{author}}
%%% Description : Description of plugin
%%%
%%% Created : Date created
%%% -------------------------------------------------------------------
-module({{pluginid}}_sup).
-author("{{author}}").

-behaviour(supervisor).

-include("{{pluginid}}.hrl").

-export([start_link/0, init/1]).

%% --------------------------------------------------------------------
%% Macros
%% --------------------------------------------------------------------
-define(SERVER, ?MODULE).

%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% ====================================================================
%% External functions
%% ====================================================================
start_link() -> 
	io:format("Configuring {{pluginid}}...", []),
	Pid = supervisor:start_link({local, ?MODULE}, ?MODULE, []),
	io:format("done~n", []),
	Pid.

%% ====================================================================
%% Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok,  {SupFlags,  [ChildSpec]} } |
%%          ignore                          |
%%          {error, Reason}
%% --------------------------------------------------------------------
init([]) ->
	Config = case application:get_env({{pluginid}}) of
		{ok, C} -> [C];
		_ -> []
	end,
	{ok, { {one_for_one, 3, 10}, [{
		{{pluginid}}, { {{pluginid}}, start_link, Config },
		permanent,
		10000,
		worker,
		[ {{pluginid}} ]
	}]} }.
