require_relative 'spec_helper'

describe Section do
  describe "#new" do
    it "always has text" do
      expect( subject.text ).to eq('')
    end

    it "takes a block and arbitrary values" do
      section = Section.new do
        blarg 'whatever'
      end

      expect( section.blarg ).to eq('whatever')
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

