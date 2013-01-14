# Git Writing Tool

The temporarily named Git Writing Tool is designed to make working with long documents more like working with source code.  It lets you split sections of documents in their own files and then compose them together using a manifest.  That way, you can easily run "git diff" on just the section you're interested in.  Or you can run git diff on the manifest, just to see how the structure of the document has changed.  More importantly, the tool lets you write paragraphs with each sentence (or even just parts of sentences) on its own line.  That way, a diff doesn't end up highlighting a whole paragraph because you changed a single character.

# Example manifest file

    compose 'MyDocument.txt' do
      text 'All you're life, you've been waiting for something...'

      section do
        heading 'Introduction'
        file 'examples-of-old-way-being-bad'
        file 'here-comes-product-x'
      end

      section do
        heading 'About Product X'
        file 'what-it-does'
        file 'how-it-will-work'
      end

      section do
        heading 'When can I get it?'
        file 'why-development-is-difficult'
        file 'why-development-is-expensive'
        file 'plea-for-money'

        text 'Thanks for reading!'
      end
    end
