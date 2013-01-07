Given /^a composition directory$/ do
  Dir.mkdir 'composition'
  Dir.chdir 'composition'
end

Given /^a directory for the sections$/ do
  Dir.mkdir 'sections'
end

Given /^a basic composition file$/ do
  text = <<-END
compose do
  section file('sections/intro')
  section file('sections/body')
  section file('sections/conclusion')
end
  END

  File.open('composition.rb', 'w') { |f| f.write text }
end

Given /^a few basic section files$/ do
  intro = <<-END
This is the introduction.
It introduces the document.
It propels you into the document by leaving you with a question.
Or does it?
  END

  body = <<-END
This is the body of the document.
It discusses, in length the topic of the document.

The topic of this document is this document.
How meta.

The body is long.
So it is normally composed of a couple of paragraphs.
Like this one.
  END

  conclusion = <<-END
The conclusion concludes things.
However, this is only the case if it is well written.
It is doubtful that you will find this conclusion satisfying.
  END

  File.open('sections/intro.txt', 'w')      { |f| f.write intro }
  File.open('sections/body.txt', 'w')       { |f| f.write body }
  File.open('sections/conclusion.txt', 'w') { |f| f.write conclusion }
end

When /^I run compose$/ do
  run_file 'composition'
end

When /^I read '(\S+)'$/ do |filename|
  puts "pwd: #{Dir.pwd}"
  puts "ls: \n#{Dir.entries('.').join("\n")}"
  puts "ls sections: \n#{Dir.entries('sections').join("\n")}"
  puts "Reading: #{filename}"
  puts File.read(filename)
end

Then /^the basic composition should be written to a text file$/ do
  output   = File.read('composition.txt')
  expected = <<-END
This is the introduction.  It introduces the document.  It propels you into the document by leaving you with a question.  Or does it?

This is the body of the document.  It discusses, in length the topic of the document.

The topic of this document is this document.  How meta.

The body is long.  So it is normally composed of a couple of paragraphs.  Like this one.

The conclusion concludes things.  However, this is only the case if it is well written.  It is doubtful that you will find this conclusion satisfying.
  END

  expect(output).to eq(expected)
end
