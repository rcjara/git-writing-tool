#!/usr/bin/env ruby

require_relative '../lib/git_writing_tool'

ARGV.each do |file|
  GWT::run_file(file)
end
