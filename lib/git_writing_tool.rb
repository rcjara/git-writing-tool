require_relative 'file_reader.rb'
require_relative 'section.rb'
require_relative 'section_displayer.rb'
require_relative 'composer.rb'

module GWT
  def compose(filename = nil, &block)
    filename ||= get_calling_file
    composer = GWT::Composer.new(filename, &block)
    File.open(composer.filename, 'w') do |f|
      f << composer.formatted_text
    end
  end

  def file(*args, &block)
    Section.new(FileReader.read(*args), &block)
  end

  def get_calling_file
    caller[0].sub(/:.*?$/, '')
  end
end
