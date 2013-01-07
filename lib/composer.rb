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

    def file(fn, &block)
      filename = self.class.clean_filename(fn)
      puts "file called: #{filename}"
      Section.new(FileReader.read(filename), &block)
    end

    def formatted_text
      displayers.collect(&:formatted_text)
                .join("\n")
    end

    def self.clean_filename(filename)
      return nil if filename.nil?

      filename.sub(/(?<=\S)(\..*$)/, '') + '.txt'
    end
  end
end

