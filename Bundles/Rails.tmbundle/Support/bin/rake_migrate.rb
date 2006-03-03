Dir.chdir ENV['TM_PROJECT_DIRECTORY']
output = `rake migrate`

if output.to_a.size == 1
  puts "Migration successful"
else
  puts "Rake reported the following:\n#{output}"
end