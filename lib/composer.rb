module GWT
  class Composer
    attr_reader :displayers

    def initialize(*args)
      @displayers = []
    end

    def section(section)
      displayers << SectionDisplayer.new(section)
    end

    def formatted_text
      displayers.collect(&:formatted_text)
                .join("\n\n")
    end

    def self.compose(*args, &block)
      composer = self.new(*args)
      composer.instance_eval &block
      composer.formatted_text
    end
  end
end

