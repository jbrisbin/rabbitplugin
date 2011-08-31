# Rebar Template for RabbitMQ Plugins

This is a rebar template for creating RabbitMQ plugins.

To use it, clone it to your `~/.rebar/templates` directory (you'll need to 
create it if it doesn't already exist):

		mkdir -p ~/.rebar/templates
		cd .rebar/templates
		git clone git://github.com/jbrisbin/rabbitplugin.git

When you're ready to start using it, use a standard rebar project create command:

		cd ~/Projects
		rebar create template=rabbitplugin pluginid=my_cool_plugin author="Joe Blow <joe@mydomain.com>"
		==> rabbitmq (create)
		Writing my_cool_plugin/rebar
		Writing my_cool_plugin/rebar.config
		Writing my_cool_plugin/Makefile
		Writing my_cool_plugin/src/my_cool_plugin.app.src
		Writing my_cool_plugin/include/my_cool_plugin.hrl
		Writing my_cool_plugin/src/my_cool_plugin.erl
		Writing my_cool_plugin/src/my_cool_plugin_app.erl
		Writing my_cool_plugin/src/my_cool_plugin_sup.erl
		
		cd my_cool_plugin
		make
		./rebar get-deps
		==> my_cool_plugin (get-deps)
		Pulling rabbit_common from {git,"git://github.com/jbrisbin/rabbit_common.git",
		                                {tag, "rabbitmq_2.6.0"}}
		Cloning into rabbit_common...
		Pulling amqp_client from {git,"git://github.com/jbrisbin/amqp_client.git",
		                              {tag, "rabbitmq_2.6.0"}}
		Cloning into amqp_client...
		==> rabbit_common (get-deps)
		==> amqp_client (get-deps)
		./rebar compile
		==> rabbit_common (compile)
		[...blah...]
		==> amqp_client (compile)
		[...blah...]
		==> my_cool_plugin (compile)
		Compiled src/my_cool_plugin_app.erl
		Compiled src/my_cool_plugin_sup.erl
		Compiled src/my_cool_plugin.erl

You can manage your other dependencies in the usual rebar way. The `package` and `install` targets 
in the provided Makefile will handle zipping those dependencies into `.ez` files.

# Install your plugin

To install your plugin, set the `RABBITMQ_HOME` environment variable for you system such that 
the installer can put your .ez files into `$RABBITMQ_HOME/plugins`:

		export RABBITMQ_HOME=/my/rabbitmq_home/2.6.0
		make install