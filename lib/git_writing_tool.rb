require_relative 'file_reader.rb'
require_relative 'section.rb'
require_relative 'section_displayer.rb'
require_relative 'composer.rb'

module GWT
  class Runner
    def initialize(filename = nil)
      @filename = filename
    end

    def compose(filename = nil, &block)
      filename ||= @filename
      composer = GWT::Composer.new(filename, &block)

      File.open(composer.filename, 'w') do |f|
        f << composer.formatted_text
      end
    end

    def get_calling_file
      full_file_path = caller[0].sub(/:.*?$/, '')
      File.basename(full_file_path)
    end

  end
end
