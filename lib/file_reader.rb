module GWT
  class FileReader
    MULTI_TAG_REGEX = /(?<pretext>.*?)(?<name>^\S+):\s+(?<content>.*?)(?<rest>^\S+:\s.*)/m
    ONE_TAG_REGEX   = /(?<pretext>.*?)(?<name>^\S+):\s+(?<content>.*)/m

    def self.read(fn)
      filename = clean_filename(fn)
      parse(File.read(filename))
    end

    def self.parse(text)
      if r = text.match(MULTI_TAG_REGEX)
        name    = r[:name].to_sym
        content = clean_content(r[:content])
        rest    = r[:rest]

        { name => content }.merge(parse(rest))
      elsif r = text.match(ONE_TAG_REGEX)
        name    = r[:name].to_sym
        content = clean_content(r[:content])

        { name => content }
      else
        { body: text }
      end
    end

    def self.clean_content(text)
      if multi_line? text
        text
      else
        text.strip
      end
    end

    def self.multi_line?(text)
      text.scan(/\n/).length > 1
    end

    def self.clean_filename(filename)
      return nil if filename.nil?

      filename.sub(/(?<=\S)(\..*$)/, '') + '.txt'
    end
  end
end

