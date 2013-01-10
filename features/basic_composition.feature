Feature: Use a composition file to create a single text document out of many smaller files.

  Background:
    Given a composition directory
      And a directory for the sections

  Scenario: A basic composition from files
    Given a few basic section files
      And a basic composition file
     When I run compose
     Then the basic composition should be written to a text file

  Scenario: A basic composition from files in multiple directories
    Given a directory full of some word definitions
      And a few basic section files
      And a composition file with multiple directory based sections
     When I run compose
     Then the multi-directory composition should be written to a text file
