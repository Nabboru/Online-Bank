require 'test_helper'

class AdminEditTransactionTest < ActionDispatch::IntegrationTest
  def setup
    load "#{Rails.root}/db/seeds.rb"
  end
  test "admin can edit a transaction" do
    post admin_login_url, params: { session: {email: "admin1@gmail.com",
       password: '12345678'}}
    assert is_admin_logged_in?
    get '/transactions/2233/edit'
    assert_template 'transactions/edit'
    put '/transactions/2233', params: {transaction: {transactionNumber: "55668800",
      transactionDate: "2020/08/03", amount: 50.00, currency: "GBP",
      sendingAccount_id: 11223344, recievingAccount_id: 12345678, description: "Payment"}}
    assert_redirected_to transactions_path(account_id:11223344)
    assert Transaction.find_by(id: 2233).description == 'Payment'
  end

  test "admin cannot do invalid edit of a transaction" do
    post admin_login_url, params: { session: {email: "admin1@gmail.com",
       password: '12345678'}}
    assert is_admin_logged_in?
    get '/transactions/2233/edit'
    assert_template 'transactions/edit'
    put '/transactions/2233', params: {transaction: {transactionNumber: "",
      transactionDate: "2020/08/03", amount: 50.00, currency: "GBP",
      sendingAccount_id: 11223344, recievingAccount_id: 12345678, description: "Payment"}}
    assert_response :success
    assert_template 'transactions/edit'
  end
end
