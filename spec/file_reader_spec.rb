require_relative 'spec_helper.rb'

describe FileReader do
  let(:basic_text_with_attributes) do
<<END
title: Fun little thing
tags: fun, exciting, memorable
text:
It totally has all kinds of text.
It totally does.
END
  end


  it "reads files with arbitrary attributes" do
    File.stub(read: basic_text_with_attributes)

    expect( FileReader.read("a file name") ).to eq({
      title: "Fun little thing",
      tags:  "fun, exciting, memorable",
      text:  "It totally has all kinds of text.\nIt totally does.\n"
    })
  end

end

