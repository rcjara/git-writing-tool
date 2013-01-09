module GWT
  class Composer
    attr_reader :section, :filename

    def initialize(filename = nil, &block)
      @filename = self.class.clean_filename(filename)
      @section = Section.new({}, &block)
    end

    def formatted_text
      section.formatted_text
    end

    def self.clean_filename(filename)
      return nil if filename.nil?

      filename.sub(/(?<=\S)(\..*$)/, '') + '.txt'
    end
  end
end

