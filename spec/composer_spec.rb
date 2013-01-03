require_relative 'spec_helper.rb'

describe Composer do
  let(:text1) { "This is section one.\n" }
  let(:text2) { "This is section two.\n" }
  let(:text3) { "This is section three.\n\nWhich has two paragraphs.\n" }

  describe "#compose" do
    subject do
      # Necessary to make the sections visible within
      # the instance_eval of the compose method
      sec1, sec2, sec3 = section1, section2, section3

      Composer.compose do
        section sec1
        section sec2
        section sec3
      end
    end

    context "without headings" do
      let(:section1) { double(formatted_text: text1,
                                     heading: nil) }
      let(:section2) { double(formatted_text: text2,
                                     heading: nil) }
      let(:section3) { double(formatted_text: text3,
                                     heading: nil) }

      it "appends sections together" do
        expect( subject ).to eq <<END
This is section one.

This is section two.

This is section three.

Which has two paragraphs.
END
      end
    end
  end
end

