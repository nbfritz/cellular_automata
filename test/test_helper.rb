require "minitest/autorun"

require "minitest/reporters"
Minitest::Reporters.use!

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))
require "cellular_automata"
