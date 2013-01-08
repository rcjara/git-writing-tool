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
      text.lines_joined
          .double_spaces_between_sentences
          .cr
          .to_s
    end

    def cleaned_heading
      return '' if heading.empty?
      "\n" + heading.cr.to_s + "\n"
    end

    def self.compose(*args, &block)
      composer = self.new(*args)
      composer.instance_eval &block
      composer.formatted_text
    end

    private

    def text
      Text.new(section.text)
    end

    def heading
      Text.new(section.heading)
    end

    class Text
      attr_reader :text

      def initialize(text)
        @text = text || ''
      end

      def empty?
        text.empty?
      end

      def to_s
        text
      end

      def lines_joined
        self.class.new text.gsub(/(?<=\S)(\n)(?=\S)/,' ')
      end

      def double_spaces_between_sentences
        self.class.new(text.gsub(/([\.\?\!])( )(?=\S)/) do |match|
          match[0] + '  '
        end)
      end

      # 'cr' stands for carriage return
      # ensures that a string ends with (at least)
      # one new line character.
      def cr
        self.class.new text.chomp + "\n"
      end
    end
  end
end


