module GWT
  class Composer
    attr_reader :sections

    def initialize(*args)
      @sections = []
    end

    def section(section)
      sections << section
    end

    def formatted_text
      sections.collect(&:formatted_text)
              .join("\n")
    end

    def self.compose(*args, &block)
      composer = self.new(*args)
      composer.instance_eval &block
      composer.formatted_text
    end
  end
end

