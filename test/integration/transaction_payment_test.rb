require 'test_helper'

class TransactioPaymentTest < ActionDispatch::IntegrationTest
  test "Unable to access transactions details if customer is not logged in" do
    get transactions_url
    assert_response :found
    assert_not  is_logged_in?
      get new_transaction_path
    assert_redirected_to customer_login_url
  end

end
