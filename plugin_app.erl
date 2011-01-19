-module({{pluginid}}_app).
-author("{{author}}").

-export([
	start/0, 
	stop/0, 
	start/2, 
	stop/1
]).

start() ->
	{{pluginid}}_sup:start_link(), 
	ok.

stop() ->
	ok.

start(normal, []) ->
	{{pluginid}}_sup:start_link().

stop(_State) ->
	ok.