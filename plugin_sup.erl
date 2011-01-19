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
%% Returns: {ok,  {SupFlags,  [ChildSpec]}} |
%%          ignore                          |
%%          {error, Reason}
%% --------------------------------------------------------------------
init([]) ->
	Workers = case application:get_env({{pluginid}}) of
							{ok, W} -> make_worker_configs(W);
							_ -> 
								io:format("no configs found...", []),
								[]
						end,
	{ok, { {one_for_one, 3, 10}, Workers} }.

make_worker_configs(Configs) ->
	lists:foldl(fun (Config, Acc) ->
		case Config of
			{Name, C} ->
				[{Name, { {{pluginid}}, start_link, [Name, C] },
				permanent,
				10000,
				worker,
				[ {{pluginid}} ]
				} | Acc]
		end
	end, [], Configs).
