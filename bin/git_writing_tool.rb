require_relative '../lib/git_writing_tool'


def run_file(filename)
  full_filename = (filename =~ /\./) ? filename : filename + '.rb'

  GWT::Runner.new(full_filename).instance_eval(File.read(full_filename))
end
