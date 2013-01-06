require_relative 'spec_helper'

describe Section do
  describe "#new" do
    it "has a default text value" do
      expect( subject.text ).to eq('')
    end

    it "can take a block and arbitrary values" do
      section = Section.new do
        blarg 'whatever'
      end

      expect( section.blarg ).to eq('whatever')
    end

    it "can take a hash of arbitrary values" do
      section = Section.new( { blarg: "whatever" } )

      expect( section.blarg ).to eq("whatever")
    end

    it "overides its hash values with block values" do
      section = Section.new( {text: "Hello\n"} ) do
        text "Goodbye\n"
      end

      expect( section.text ).to eq("Goodbye\n")
    end
  end

  describe "arbitrary value setting" do
    context "on setting a value for bada" do
      subject do
        Section.new.tap { |s| s.bada 'bing' }
      end

      it "raises a method missing error if you try access other values" do
        expect { subject.blarg }.to raise_error(NoMethodError)
      end

      it "returns the right value for bada" do
        expect( subject.bada ).to eq('bing')
      end
    end
  end
end

