# Preview all emails at http://localhost:3000/rails/mailers/code_mailer
class CodeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/code_mailer/new_code
  def new_code
    CodeMailer.new_code("240","m@m")
  end

end
