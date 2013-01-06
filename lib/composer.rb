module GWT
  class Composer
    attr_reader :displayers

    def initialize(*args)
      @displayers = []
    end

    def section(section = nil, &block)
      section = Section.new(&block) unless section
      displayers << SectionDisplayer.new(section)
    end

    def formatted_text
      displayers.collect(&:formatted_text)
                .join("\n")
    end

    def self.compose(*args, &block)
      composer = self.new(*args)
      composer.instance_eval &block
      composer.formatted_text
    end
  end
end

