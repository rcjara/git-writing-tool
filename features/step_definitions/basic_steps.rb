####################
# background setup #
####################
Given /^a composition directory$/ do
  Dir.mkdir 'composition'
  Dir.chdir 'composition'
end

Given /^a directory for the sections$/ do
  Dir.mkdir 'sections'
end
#
#######################
# further text files  #
#######################
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

Given /^a directory full of some word definitions$/ do
  aardvark = <<-END
aardvark -
An aardvark is a silly animal.
  END

  emu = <<-END
emu -
An emu is a less silly animal, but still odd.
  END

  Dir.mkdir 'definitions'
  File.open('definitions/aardvark.txt', 'w') { |f| f.write aardvark }
  File.open('definitions/emu.txt', 'w')      { |f| f.write emu }
end

#####################
# composition files #
#####################
Given /^a basic composition file$/ do
  text = <<-END
compose do
  file 'sections/intro'
  file 'sections/body'
  file 'sections/conclusion'
end
  END

  File.open('composition.rb', 'w') { |f| f.write text }
end

Given /^a composition file with multiple directory based sections$/ do
  text = <<-END
compose do
  section do
    heading 'Definitions'
    directory 'definitions'
    text 'Here are some definitions of animals:'
    file 'aardvark'
    file 'emu'
  end

  section do
    directory 'sections'
    heading 'Main Body'
    file 'intro'
    file 'body'
    file 'conclusion'
  end
end
    END

  File.open('composition.rb', 'w') { |f| f.write text }
end

########
# when #
########
When /^I run compose$/ do
  GWT::run_file 'composition'
end

When /^I read '(\S+)'$/ do |filename|
  puts "pwd: #{Dir.pwd}"
  puts "ls: \n#{Dir.entries('.').join("\n")}"
  puts "ls sections: \n#{Dir.entries('sections').join("\n")}"
  puts "Reading: #{filename}"
  puts File.read(filename)
end

################
# result files #
################
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

Then /^the multi\-directory composition should be written to a text file$/ do
  output   = File.read('composition.txt')
  expected = <<-END

Definitions

Here are some definitions of animals:

aardvark - An aardvark is a silly animal.

emu - An emu is a less silly animal, but still odd.


Main Body

This is the introduction.  It introduces the document.  It propels you into the document by leaving you with a question.  Or does it?

This is the body of the document.  It discusses, in length the topic of the document.

The topic of this document is this document.  How meta.

The body is long.  So it is normally composed of a couple of paragraphs.  Like this one.

The conclusion concludes things.  However, this is only the case if it is well written.  It is doubtful that you will find this conclusion satisfying.
  END
  expect(output).to eq(expected)
end

