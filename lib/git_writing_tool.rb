require_relative 'file_reader.rb'
require_relative 'section.rb'
require_relative 'section_displayer.rb'
require_relative 'composer.rb'

module GWT
  def compose(*args, &block)
    GWT::Composer.compose(*args, &block)
  end
end

include GWT
