# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

#default admin
AdminUser.new(email:"admin@gmail.com", password:"admin123",
  password_confirmation: "admin123").save

#Fake company customer and its accounts
customer = Customer.new(customerNumber: 10000000, email: "fakeCompanies123@gmail.com",
  forename: "Fake", surname: "Companies", phone: "44123451234",
  dob: "10/11/1996", password: "12345678", password_confirmation: "12345678", verification:false)
customer.save
accountList = [Account.new(accountNumber:100000000000001, accountName:"Supermarket", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000002, accountName:"Transport", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000003, accountName:"E-commerce", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000004, accountName:"Chemist", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000005, accountName:"Cafe", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000006, accountName:"Gym membership", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000007, accountName:"Clothing retailer", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000008, accountName:"Restaurant", balance: 0, currency: "GBP"),
  Account.new(accountNumber:100000000000009, accountName:"Bookshop", balance: 0, currency: "GBP")]
accountList.each do |a|
  customer.accounts << a
  a.save
end

customer = Customer.new(customerNumber:20000000, email: 'jeremy@gmail.com',
  forename: 'Jeremy', surname: 'Williams', phone: "44123451234", dob: '12/12/1970',
  password: '12345678', password_confirmation: '12345678', verification: true)
customer.save
accountList = [Account.new(accountNumber:200000000000001, accountName:"Basic", balance: 2000, currency: "GBP"),
  Account.new(accountNumber:200000000000002, accountName:"Savings", balance: 2000, currency: "GBP")]
accountList.each do |a|
  customer.accounts << a
  a.save
end

customer = Customer.new(customerNumber:30000000, email: 'andy@gmail.com',
  forename: 'Andy', surname: 'Jones', phone: "44123451234", dob: '12/12/1970',
  password: '12345678', password_confirmation: '12345678', verification: false)
customer.save
accountList = [Account.new(accountNumber:300000000000001, accountName:"Basic", balance: 1000000, currency: "GBP"),
  Account.new(accountNumber:300000000000002, accountName:"Reward", balance: 2000, currency: "GBP")]
accountList.each do |a|
  customer.accounts << a
  a.save
end

customer = Customer.new(customerNumber:40000000, email: 'sara@gmail.com',
  forename: 'Sara', surname: 'James', phone: "44123451234", dob: '12/12/1970',
  password: '12345678', password_confirmation: '12345678', verification:false)
customer.save
account = Account.new(accountNumber:400000000000001, accountName:"Basic", balance: 2938, currency: "GBP")
customer.accounts << account
account.save

customer = Customer.new(customerNumber:50000000, email: 'robert@gmail.com',
  forename: 'Robert', surname: 'Clark', phone: "44123451234", dob: '12/12/1970',
  password: '12345678', password_confirmation: '12345678', verification: false)
customer.save
accountList = [Account.new(accountNumber:500000000000001, accountName:"Basic", balance: 3124, currency: "GBP"),
  Account.new(accountNumber:500000000000002, accountName:"Savings", balance: 100, currency: "GBP")]
accountList.each do |a|
  customer.accounts << a
  a.save
end
