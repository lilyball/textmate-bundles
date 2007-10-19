# MyPlugin - A plugin for Movable Type.
# Copyright (c) ${TM_YEAR}, ${TM_FULLNAME}.

package MT::Plugin::MyPlugin;

use 5.006;    # requires Perl 5.6.x
use MT 3.2;   # requires MT 3.2 or later

use base 'MT::Plugin';
our $VERSION = '1.0';

my $plugin;
MT->add_plugin($plugin = __PACKAGE__->new({
	name            => "My Plugin",
	version         => $VERSION,
	description     => "Description of this plugin.",
	author_name     => "${TM_FULLNAME}",
	author_link     => "http://www.example.com/",
	plugin_link     => "http://www.example.com/myplugin/",
	doc_link        => "http://www.example.com/myplugin/docs/",
	settings        => new MT::Plugin::Settings([
		['name', { Default => 'default' }]
	]),
	config_template => 'config.tmpl',  # in MT/plugins/myplugin/tmpl/
}));

# Allows external access to plugin object: MT::Plugin::MyPlugin->instance
sub instance {
	$plugin;
}

# called once, at startup of plugin
sub init {
	my $plugin = shift;
	$plugin->SUPER::init(@_);
}

# called upon initialization of each application
sub init_app {
	my $plugin = shift;
	my ($app) = @_;
	$plugin->SUPER::init_app(@_);
}

# called upon initialization of each request to the application
sub init_request {
	my $plugin = shift;
	my ($app) = @_;
	$plugin->SUPER::init_request(@_);
}

1;