# MyPlugin
# A plugin for Movable Type.
# Copyright (c) ${TM_YEAR}, ${TM_USERNAME}.

package MyPlugin;

use MT 3.3;

MT->add_plugin({
	name => "My Plugin",
	version => '1.0',
	description => "Description of this plugin.",
	author_name => "${TM_USERNAME}",
	author_link => "http://www.example.com/",
	plugin_link => "http://www.example.com/myplugin/",
	doc_link => "http://www.example.com/myplugin/docs/",
	callbacks => {
		pre_run => \&pre_run,
	}
});

sub pre_run {
	my ($eh, $app) = @_;
	my $plugin = $eh->plugin;
}

1;