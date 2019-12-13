require 'fileutils'

class Temp_Class
  def initialize(name)
    @name = name
  end
  def add_attr(attr_array)
    @attr_array = attr_array
  end
  def show_self
    puts @name
    puts @attr_array
  end
end
class Temp_Attr
  def initialize(name)
    @name = name
    # @private = private
  end
end


# whats the name of your project
puts "Name of your project"
project_name = gets.chomp.downcase

FileUtils.mkdir "./#{project_name}"
FileUtils.mkdir "./#{project_name}/lib"
FileUtils.mkdir "./#{project_name}/spec"
class_names = []

gemfile_contents = "
source 'https://rubygems.org'

gem 'rspec'
gem 'pry'
"

FileUtils.touch "./#{project_name}/GemFile"
File.write("./#{project_name}/GemFile", gemfile_contents)
class_array = []
got_classes = false
# Get User Classes
while got_classes == false
  puts "Name a class or type 'done' to move on: "
  temp = gets.chomp
  if temp.downcase == 'done'
    got_classes = true
  else
    # Make class and ask for attributes
    temp_class = Temp_Class.new(temp)
    got_attr = false
    attr_array = []

    while got_attr == false
      puts "Attribute Name? Type 'done' to move one: "
      temp = gets.chomp

      if temp.downcase == 'done'
        got_attr = true
      else
        temp_attr = Temp_Attr.new(temp)
        attr_array.push(temp_attr)
      end
      attr_array.each do |attr|
        temp_class.add_attr(attr)
      end
      class_array.push(temp_class)
    end
  end
end

class_array.each do |classy|
  classy.show_self()
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
File.write("./#{project_name}/lib/#{name.downcase}.rb", generic_class_content)
File.write("./#{project_name}/spec/#{name.downcase}_spec.rb", generic_spec_content)
end

# Need to figure out : --------------------

# Bundle Install


# # Get Attributes : -----------------------
# get_attr = false
# attr_names = []
#
# while get_attr == false
#   puts "Attribute Names? type 'done' to move on"
#   temp_attr_name = gets.chomp
#   if temp_attr_name.downcase == 'done'
#     get_attr = true
#
#     attr_names = []
#   else
#     attr_names.push(temp_attr_name)
#   end
#   class_names.push(temp)
# end
