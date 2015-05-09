require 'tk'
require 'tkextlib/tile'


RUBY_CLASS_FOLDER = File.join('.', 'ruby', 'class')

Dir["#{RUBY_CLASS_FOLDER}/**/*.rb"].each { |m| require m }