class CustomerSessionController < ApplicationController
before_action :redirect_if_logged_in, only: [:new, :create]

@@code = ""

  def new
  end

  def create
    customer = Customer.find_by(email: params[:session][:email].downcase)
    if customer && customer.authenticate(params[:session][:password])
      
      #log_in(customer)
      if(customer.verification == false)
        log_in(customer)
        redirect_to(accounts_path)
      else
        params[:codeEmail] = params[:session][:email].downcase
        @@code = code_generate(customer)
        newVerification
      end  
    else
      flash.now[:danger] = "No valid credentials were provided"
      render 'new'
    end
  end

  def newVerification
    render 'verification'

  end

  def verification
    code = params[:session][:code]
    customer = Customer.find_by(params[:codeEmail])
    if code == @@code
      log_in(customer)
      redirect_to(accounts_path)
    else
      flash.now[:danger] = "Invalid Code Submitted"
      render 'verification'
    end
  end

  def destroy
    log_out
    redirect_to(root_url)
  end

  def self.getCode
    return @@code
  end  
end
