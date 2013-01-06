module GWT
  class SectionDisplayer
    attr_reader :section

    def initialize(section)
      @section = section
    end

    def formatted_text
      cleaned_heading +
      cleaned_text
    end

    def cleaned_text
      cr section.text.gsub(/(?<=\S)(\n)(?=\S)/,'  ')
    end

    def cleaned_heading
      return '' if section.heading.nil?
      "\n" + cr(section.heading) + "\n"
    end

    # 'cr' stands for carriage return
    # ensures that a string ends with (at least)
    # one new line character.
    def cr(text)
      text.chomp + "\n"
    end

    def self.compose(*args, &block)
      composer = self.new(*args)
      composer.instance_eval &block
      composer.formatted_text
    end
  end
end


