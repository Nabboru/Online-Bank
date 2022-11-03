require 'test_helper'

class CustomerLoginTest < ActionDispatch::IntegrationTest
  test "login redirects to verification when verify enabled" do
    get customer_login_url
    assert_response :success
    assert_not is_logged_in?
    assert_template 'customer_session/new'
    post customer_login_url, params: { session: {email: "bob@gmail.com",
       password: '12345678'}}
    assert_template 'customer_session/verification'
    
  end

  test "verification with incorrect code" do
    get customer_login_url
    assert_response :success
    assert_not is_logged_in?
    assert_template 'customer_session/new'
    post customer_login_url, params: { session: {email: "bob@gmail.com",
       password: '12345678'}}
    assert_template 'customer_session/verification'
    post '/customer/verify', params: { session: {code:"somecode"}}
    assert_response :success
    assert_template 'customer_session/verification'
    assert_not is_logged_in?

  end

  test "verification with correct code" do
    get customer_login_url
    assert_response :success
    assert_not is_logged_in?
    assert_template 'customer_session/new'
    post customer_login_url, params: { session: {email: "bob@gmail.com",
       password: '12345678'}}
    assert_template 'customer_session/verification'
    code = CustomerSessionController.getCode
    post '/customer/verify', params: { session: {code: code }}
    assert_redirected_to accounts_path
    follow_redirect!
    assert_template 'accounts/index'
    assert is_logged_in?

  end
end