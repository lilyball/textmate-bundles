#!/usr/bin/env ruby -wKU

require './keychain'
require 'test/unit'

class TestKeychain < Test::Unit::TestCase
  KeychainItemData = {
    :account  => 'keychain-testing',
    :server   => 'keychain-testing',
    :protocol => OSX::Keychain::ProtocolType::Telnet,
    :auth     => OSX::Keychain::AuthenticationType::HTTPBasic,
    :port     => 0,
    :path     => 'baz'
  }

  def setup
    OSX::Keychain.destroy_internet_password_for(KeychainItemData)
  end
  
  def test_create_and_fetch
    assert OSX::Keychain.set_internet_password_for(KeychainItemData.merge(:password => "Password"))
    assert_equal(OSX::Keychain.internet_password_for(KeychainItemData), "Password")
  end
end
