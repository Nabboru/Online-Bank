module AccountsHelper
  def generateAccountNumber
    accountNumber = rand(1000000000000000..9999999999999999)
  end

  def generateBalance
    balance = rand(100..100000)
  end

  def formatBalance(account)
    formatString = ""
    if (account.currency == "GBP")
      formatString = "£"
    elsif (account.currency == "EUR")
      formatString = "€"
    else
      formatString = "$"
    end
    formattedBalance = "#{account.balance}"
    formatString = formatString + formattedBalance
  end

  def generateTransactionHistory(account)
    # Create transactions which has the new account as sender and the 'companies'
    # as receiver
    for i in 0..10 do
      newTransaction = Transaction.new(sendingAccount_id: account.id,
        transactionNumber: generateTransactionNumber,
        transactionDate: randomTime,
        recievingAccount_id: randomCompanyAccount.id, amount: randomAmount,
        currency: randomCurrency)
        if newTransaction.valid? && processPayment(newTransaction)
          newTransaction.save
        end
    end
    # Create transactions which has random accounts (that are not 'companies')
    # as sender and the new account as receiver,
    # in case there are no accounts this part is not executed
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


  # Based on
  # stackoverflow.com/questions/4894198/how-to-generate-a-random-date-in-ruby
  def randomTime from = Time.local(2020, 11, 1), to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  def randomAmount
    rand(1..300)
  end

  def randomCompanyAccount
    #look for accounts that are companies (they belong to customer of
    # customerNumber 10000000)
    list = Customer.find_by(customerNumber: 10000000).accounts
    list.sample
  end

  def randomAccount(account)
    #look for accounts that are not companies (they do not belong to customer of
    # customerNumber 10000000) and that are not the new accont
    list = Account.all.select do |a| a != account && !Customer.find_by(customerNumber: 10000000).accounts.include?(a) end
    list.sample
  end

  def randomCurrency
    ["GBP", "USD", "EUR"].sample
  end

end
