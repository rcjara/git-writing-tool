require_relative 'composer.rb'

module GWT
  def compose(*args, &block)
    GWT::Composer.compose(*args, &block)
  end
end

include GWT
