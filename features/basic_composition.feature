Feature: Use a composition file to create a single text document out of many smaller gwt files.

  Background:
    Given a composition directory
      And a directory for the sections

  Scenario: Writing to a file
    Given a basic composition file
      And a few basic section files
     When I run compose
     Then the basic composition should be written to a text file

