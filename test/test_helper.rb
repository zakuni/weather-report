require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require 'weather-report'

MiniTest::Reporters.use! [MiniTest::Reporters::DefaultReporter.new, MiniTest::Reporters::GuardReporter.new]
