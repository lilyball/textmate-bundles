require 'plist'
require 'stringio'
require 'test/unit'

class TestPlist < Test::Unit::TestCase
	def test_string
		plist = PropertyList.load("{foo = bar; }")
		assert_equal( { "foo" => "bar" }, plist )

		plist, format = PropertyList.load("{foo = bar; }", true)
		assert_equal( { "foo" => "bar" }, plist )
		assert_equal( :openstep, format )
		
		# make sure sources < 6 characters work
		plist = PropertyList.load("foo")
		assert_equal( "foo", plist )
		
		# make sure it works with format too
		plist, format = PropertyList.load("foo", true)
		assert_equal( "foo", plist )
		assert_equal( :openstep, format )
		
		assert_raise(PropertyListError) { PropertyList.load("") }
	end

	def setup_hash
		time = Time.gm(2005, 4, 28, 6, 32, 56)
		random = "\x23\x45\x67\x89"
		random.blob = true
		{
			"string!" => "indeedy",
			"bar" => [ 1, 2, 3 ],
			"foo" => {
				"correct?" => true,
				"pi" => 3.14159265,
				"random" => random,
				"today" => time,
			}
		}
	end

	def test_io
		plist = PropertyList.load(DATA)

		hash = setup_hash

		assert_equal(hash, plist)
		assert_equal(true, plist['foo']['random'].blob?)
		assert_equal(false, plist['string!'].blob?)
	end

	def test_dump
		str = StringIO.new("", "w")
		hash = setup_hash
		PropertyList.dump(str, hash)
		hash2 = PropertyList.load(str.string)
		assert_equal(hash, hash2)
	end

	def test_to_plist
		assert_raise(PropertyListError) { "foo".to_plist(:openstep) }
		assert_equal("foo", PropertyList.load("foo".to_plist))
	end
end

__END__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>string!</key>
	<string>indeedy</string>
	<key>bar</key>
	<array>
		<integer>1</integer>
		<integer>2</integer>
		<integer>3</integer>
	</array>
	<key>foo</key>
	<dict>
		<key>correct?</key>
		<true/>
		<key>pi</key>
		<real>3.14159265</real>
		<key>random</key>
		<data>
		I0VniQ==
		</data>
		<key>today</key>
		<date>2005-04-28T06:32:56Z</date>
	</dict>
</dict>
</plist>
