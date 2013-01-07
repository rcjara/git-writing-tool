require_relative '../../bin/git_writing_tool.rb'
require 'fakefs/safe'

Before do
  FakeFS.activate!
end

After do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!
end
