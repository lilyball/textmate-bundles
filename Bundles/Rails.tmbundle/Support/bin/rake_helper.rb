Dir.chdir ENV['TM_PROJECT_DIRECTORY']
command = "rake #{ARGV.shift}"
output = `#{command}`

if output.to_a.size <= 1
  puts "#{command} successful"
else
  puts "Rake reported the following:\n#{output}"
end