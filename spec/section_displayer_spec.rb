require_relative 'spec_helper'
describe SectionDisplayer do
  let(:multi_line_sentences) do
    <<-END
This is a sentence that,
while it might not be the most elegant or gramatical,
benefits from being split accross a few lines.
This is another sentence
(this one with a parenthetical)
that benefits from being split.
    END
  end

  let(:multi_line_sentences_output) do
    <<-END
This is a sentence that, while it might not be the most elegant or gramatical, benefits from being split accross a few lines.  This is another sentence (this one with a parenthetical) that benefits from being split.
    END
  end

  describe ".cleaned_text" do
    it "appends together fractions of sentences written accross multiple lines" do
      section = double('section', text: multi_line_sentences)
      expect( SectionDisplayer.new(section).cleaned_text )
        .to eq(multi_line_sentences_output)
    end
  end
end
