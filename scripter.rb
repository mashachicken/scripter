require 'fileutils'

FileUtils.mkdir './lib'
FileUtils.mkdir './spec'
FileUtils.touch './GemFile'
class_names = []

gemfile_contents = "
source 'https://rubygems.org'

gem 'rspec'
gem 'pry'
"

IO.write('./GemFile', gemfile_contents)

got_classes = false

while got_classes == false
  puts "Name a class or type 'done' to move on: "
  temp = gets.chomp
  if temp.downcase == 'done'
    got_classes = true
  else
    class_names.push(temp)
  end
end

# Loop through class names, generate files and add the contents
class_names.each do |name|
generic_class_content = "
class #{name.capitalize}
end
"
generic_spec_content = "
require '#{name.downcase}.rb'
describe('#{name.capitalize}') do
end
"
IO.write("./lib/#{name.downcase}.rb", generic_class_content)
IO.write("./spec/#{name.downcase}_spec.rb", generic_spec_content)
end
