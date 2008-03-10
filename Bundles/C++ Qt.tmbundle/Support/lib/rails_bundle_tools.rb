bundle_lib = ENV['TM_BUNDLE_SUPPORT'] + '/lib'
$LOAD_PATH.unshift(bundle_lib) if ENV['TM_BUNDLE_SUPPORT'] and !$LOAD_PATH.include?(bundle_lib)

require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

require 'rails/text_mate'
require 'rails/unobtrusive_logger'
require 'rails/misc'
require 'camelcase'