require 'test_helper'

class AccountsHelperTest < ActionView::TestCase

  def setup
    @account = Account.new({accountName: "Basic Account",
      accountNumber: "12345678", balance: 1234.56, currency: "GBP"})
  end

  test "valid formatted balance for GBP" do
    formattedString = formatBalance(@account)
    assert_equal(formattedString, "£1234.56")
  end

  test "valid formatted balance for EUR" do
    @account.currency = "EUR"
    formattedString = formatBalance(@account)
    assert_equal(formattedString, "€1234.56")
  end

  test "valid formatted balance for USD" do
    @account.currency = "USD"
    formattedString = formatBalance(@account)
    assert_equal(formattedString, "$1234.56")
  end

  test "Generate Transaction History" do
    require "#{Rails.root}/db/seeds.rb"
    customer = Customer.new({id: 1, customerNumber: 1234567867,
      email: "peter123@gmail.com", forename: "peter", surname: "smith",
      phone: "44123451234", dob: "10/11/1996", password: "12345678",
      password_confirmation: "12345678"})
    customer.save
    account = Account.new({id: 20, accountName: "Basic Account",
    accountNumber: "12345678", balance: 1234.56, currency: "GBP"})
    customer.accounts << account
    assert account.valid?
    account.save
    l = Transaction.all.length
    assert generateTransactionHistory(account)
    assert Transaction.all.length > l
    assert Transaction.find_by(sendingAccount_id: 20)
  end
end
