ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  load "#{Rails.root}/db/seeds.rb"
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:customer_id].nil?
  end

  def is_admin_logged_in?
    !session[:admin_user_id].nil?
  end

  def generateTransactionHistory(account)
    for i in 0..10 do
      newTransaction = Transaction.new(sendingAccount_id: account.id,
        transactionNumber: generateTransactionNumber,
        transactionDate: randomTime,
        recievingAccount_id: randomCompanyAccount.id, amount: randomAmount,
        currency: randomCurrency)
        if newTransaction.valid? && processPayment(newTransaction)
          newTransaction.save
        else
          false
        end
    end
    if(randomAccount(account) != nil)
      for j in 0..2 do
        newTransaction = Transaction.new(recievingAccount_id: account.id,
          transactionNumber: generateTransactionNumber,
          transactionDate: randomTime,
          sendingAccount_id: randomAccount(account).id, amount: randomAmount,
          currency: randomCurrency)
          if newTransaction.valid? && processPayment(newTransaction)
            newTransaction.save
          end
      end
    end
  end


  # Based on https://stackoverflow.com/questions/4894198/how-to-generate-a-random-date-in-ruby
  def randomTime from = Time.local(2020, 11, 1), to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  def randomAmount
    rand(1..300)
  end

  def randomCompanyAccount
    list = Customer.find_by(customerNumber: 10000000).accounts
    list.sample
  end

  def randomAccount(account)
    #look for accounts that are not companies (they do not belong to customer of customerNumber 1) and that are not the new accont
    list = Account.all.select do |a| a != account && !Customer.find_by(customerNumber: 10000000).accounts.include?(a) end
    list.sample
  end

  def randomCurrency
    ["GBP", "USD", "EUR"].sample
  end

  def generateTransactionNumber
    generatedValue = rand(100000000..999999999)
    if (Transaction.where(transactionNumber: generatedValue).count > 0)
      generateTransactionNumber
    else
      generatedValue
    end
  end

  def processPayment(transaction)
    sendingAccount = Account.find(transaction.sendingAccount_id)
    recievingAccount = Account.find(transaction.recievingAccount_id)
    if sendingAccount == recievingAccount
      false
    else
      sendingAccount.balance = sendingAccount.balance -
      currencyConversion(transaction.amount, sendingAccount.currency, transaction.currency)
      recievingAccount.balance = recievingAccount.balance +
      currencyConversion(transaction.amount, recievingAccount.currency, transaction.currency)
      if sendingAccount.balance < 0 || recievingAccount.balance < 0
        false
      end
      if sendingAccount.valid? && recievingAccount.valid?
          sendingAccount.save
          recievingAccount.save
        true
      else
        false
      end
    end
  end

  def currencyConversion(amount, accountCurrency, currency)
    if (accountCurrency == "GBP" && currency == "EUR")
      amount * 1.10
    elsif (accountCurrency == "GBP" && currency == "USD")
      amount * 1.33
    elsif (accountCurrency == "EUR" && currency == "USD")
      amount * 1.33
    elsif (accountCurrency == "EUR" && currency == "GBP")
      amount * 0.91
    elsif (accountCurrency == "USD" && currency == "GBP")
      amount * 0.75
    elsif (accountCurrency == "USD" && currency == "EUR")
      amount * 0.82
    else
      amount
    end
  end

end
