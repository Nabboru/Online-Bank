require 'test_helper'

class CodeMailerTest < ActionMailer::TestCase
  test "new_code" do
    mail = CodeMailer.new_code("New code","to@example.org")
    assert_equal "Your code", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "New code", mail.body.encoded
  end

end