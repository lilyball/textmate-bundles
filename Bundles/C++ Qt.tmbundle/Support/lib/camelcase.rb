# copied from "Source -> Toggle CamelCase / underscore_delimited" command

# [hH]otFlamingCats -> hot_flaming_cats
def camelcase_to_underscore(word)
	word[0] = word[0].chr.downcase
	word.gsub(/([A-Z])/, "_\\1").downcase
end

# hot_flaming_cats -> hotFlamingCats
def underscore_to_camelcase(word)
	word.gsub(/\_(.)/) {|c| c[1].chr.upcase}
end

# hot_flaming_cats.cpp -> HotFlamingCats
def underscore_to_classname(word)
  word = underscore_to_camelcase(word)
  word[0] = word[0].chr.upcase
  word.split('.')[0..-2].join('.')
end

def is_camel(word)
  word.match(/[A-Z]/) ? true : false
end
