require_relative 'spec_helper'

describe Section do
  describe "#new" do
    it "has a default body value" do
      expect( subject.body ).to eq('')
    end

    it "has 0 subsections" do
      expect( subject.subsections.length ).to eq(0)
    end

    it "can take a block with values" do
      section = Section.new do
        body 'whatever'
      end

      expect( section.body ).to eq('whatever')
    end

    it "can take a hash of values" do
      section = Section.new( { body: "whatever" } )

      expect( section.body ).to eq("whatever")
    end

    it "overides its hash values with block values" do
      section = Section.new( {heading: "Hello\n"} ) do
        heading "Goodbye\n"
      end

      expect( section.heading ).to eq("Goodbye\n")
    end


  end

  describe ".text" do
    it "can take multiple text subsections" do
      section = Section.new do
        text '1'
        text '2'
        text '3'
      end

      expect( section.subsections.length ).to eq(3)
    end
  end

  describe ".file" do
    it "can take multiple file subsections" do
      FileReader.should_receive(:read)
                .exactly(2).times
                .with('some_file_name')
                .and_return({does_not: 'matter'})

      section = Section.new do
        file 'some_file_name'
        file 'some_file_name'
      end

      expect( section.subsections.length ).to eq(2)
    end

    it "is automatically passed the sections' directory" do
      FileReader.should_receive(:read)
                .with('sections/some_file_name')
                .and_return({does_not: 'matter'})
      section = Section.new do
        directory 'sections'
        file 'some_file_name'
      end
    end
  end

  describe ".directory" do
    it "adds trailing '/'" do
      section = Section.new do
        directory 'some_dir'
      end

      expect( section.directory ).to eq('some_dir/')
    end

    it "does not add trailing '/' if already present" do
      section = Section.new do
        directory 'some_dir/'
      end

      expect( section.directory ).to eq('some_dir/')
    end

    it "can be nested" do
      FileReader.should_receive(:read)
                .with('outer_dir/inner_dir/file')
                .and_return({does_not: 'matter'})

      section = Section.new do
        directory 'outer_dir'
        section do
          directory 'inner_dir'

          file 'file'
        end
      end

      expect( section.directory ).to eq('outer_dir/')
    end
  end

  describe ".formatted_text" do
    it "calls a section displayer to get its formatted text" do
      section = Section.new
      SectionDisplayer.should_receive(:new)
                      .with(section)
                      .and_return(double.as_null_object)
      section.formatted_text
    end

    context "with a nested structure" do
      subject do
        Section.new do
          text "Hello"

          section do
            heading "Nested Heading"
            text "nested content 1"
            text "nested content 2"
          end

          text "Goodbye"
        end
      end

      it "displays properly" do
        expect( subject.formatted_text ).to eq(
          <<-END
Hello


Nested Heading

nested content 1

nested content 2

Goodbye
          END
        )
      end

      it "has 3 subsections" do
        expect( subject.subsections.length ).to eq(3)
      end

    end
  end
end

