require "erb"

  # Create template.
  template = %q{
    From:  James Edward Gray II <james@grayproductions.net>
    To:  <%= to %>
    Subject:  Addressing Needs


    Just wanted to send a quick note assuring that your needs are being
    addressed.

    I want you to know that my team will keep working on the issues,
    especially:

    Thanks for your patience.

    James Edward Gray II
  }.gsub(/^  /, '')

  message = ERB.new(template)

  # Set up template data.
  to = "Community Spokesman <spokesman@ruby_community.org>"

  email = message.result
  puts email