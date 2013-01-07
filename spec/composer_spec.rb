require_relative 'spec_helper.rb'

describe Composer do
  let(:text1) { "This is section one.\n" }
  let(:text2) { "This is section two.\n" }
  let(:text3) { "This is section three.\n\nWhich has two paragraphs.\n" }

  let(:simple_result) do
    <<-END
This is section one.

This is section two.

This is section three.

Which has two paragraphs.
    END
  end

  let(:result_with_headings) do
    <<-END

Section 1

This is section one.


Section 2

This is section two.


Section 3

This is section three.

Which has two paragraphs.
    END
  end

  describe ".new" do
    it "does not have a filename set by default" do
      expect( subject.filename ).to be_nil
    end

    it "can take a file name" do
      c = Composer.new("destination")
      expect( c.filename ).to eq("destination.txt")
    end
  end

  describe "#clean_filename" do
    it "add a .txt extension if none is provided" do
      expect( Composer.clean_filename("dest") ).to eq("dest.txt")
    end

    it "add a .txt extension if it does not already end with one" do
      expect( Composer.clean_filename("dest.rb") ).to eq("dest.txt")
    end

    it "returns nil if given nil" do
      expect( Composer.clean_filename(nil) ).to be_nil
    end

    it "returns the original name if it had a '.txt' extension" do
      expect( Composer.clean_filename("dest.txt") ).to eq("dest.txt")
    end
  end


  describe ".formatted_text" do
    describe "with premade sections" do
      subject do
        # Necessary to make the sections visible within
        # the instance_eval of the compose method
        sec1, sec2, sec3 = section1, section2, section3

        Composer.new do
          section sec1
          section sec2
          section sec3
        end
      end

      context "just text" do
        let(:section1) { double(text:    text1,
                                heading: nil) }
        let(:section2) { double(text:    text2,
                                heading: nil) }
        let(:section3) { double(text:    text3,
                                heading: nil) }

        it "appends sections together" do
          expect( subject.formatted_text ).to eq(simple_result)
        end
      end

      context "with headings" do
        let(:section1) { double(text:    text1,
                                heading: 'Section 1') }
        let(:section2) { double(text:    text2,
                                heading: 'Section 2') }
        let(:section3) { double(text:    text3,
                                heading: 'Section 3') }

        it "appends sections together" do
          expect( subject.formatted_text ).to eq(result_with_headings)
        end
      end
    end

    describe "with block defined sections" do
      subject do
        t1, t2, t3 = text1, text2, text3

        Composer.new do
          section do
            text t1
          end

          section do
            text t2
          end

          section do
            text t3
          end
        end
      end

      it "appends the sections together" do
        expect( subject.formatted_text ).to eq(simple_result)
      end
    end
  end
end

