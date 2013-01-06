module GWT
  class Composer
    attr_reader :displayers, :filename

    def initialize(filename = nil, &block)
      @filename = self.class.clean_filename(filename)
      @displayers = []

      instance_eval &block if block
    end

    def section(section = nil, &block)
      section = Section.new(&block) unless section
      displayers << SectionDisplayer.new(section)
    end

    def formatted_text
      displayers.collect(&:formatted_text)
                .join("\n")
    end

    def self.clean_filename(filename)
      return nil if filename.nil?

      File.extname(filename).empty? ? filename + '.txt' : filename
    end
  end
end

