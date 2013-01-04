require_relative 'composer.rb'
require_relative 'section_displayer.rb'

module GWT
  def compose(*args, &block)
    GWT::Composer.compose(*args, &block)
  end
end

include GWT
