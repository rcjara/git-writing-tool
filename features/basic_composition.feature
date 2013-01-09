Feature: Use a composition file to create a single text document out of many smaller gwt files.

  Background:
    Given a composition directory
      And a directory for the sections

  Scenario: A basic composition from files
    Given a few basic section files
      And a basic composition file
     When I run compose
     Then the basic composition should be written to a text file
