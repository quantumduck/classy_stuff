class BankAccount

####### Class Variables ############
  @@itr_rate = 1.0 # float, percentage
  @@accounts = []

####### Class Methods ###############
  def self.create(name = "Account #{@@accounts.length}")
    @@accounts << BankAccount.new(name)
    @@accounts[-1]
  end

  def self.total_funds
    funds = 0
    @@accounts.each do |account|
      funds += account.balance
    end
    funds
  end

  def self.interest_time
    @@accounts.each do |account|
      account.gain_interest
    end
  end

############## Instance Methods ################
  def initialize(name)
    @balance = 0
    @name = name
  end

  attr_reader :balance

  def balance_inq
    if (@balance < -1_000_000)
      puts "The debt collectors are coming!"
    elsif(@balance < 0)
      puts "Your account is overdrawn!"
    elsif(@balance > 1_000_000)
      puts "Thanks for being a valued customer!"
    end
    (@balance.to_f / 100.0).round(2)
  end

  def deposit(amount)
    amount = (amount * 100).to_i
    if (amount > 0)
      @balance += amount
    else
      puts "Please deposit a positive amount of money."
    end
    balance_inq
  end

  def withdraw(amount)
    amount = (amount * 100).to_i
    if (amount > 0)
      if (amount > @balance)
        puts "You have a balance of only $#{@balance}. Are you sure? (y/N)"
        answ = gets.strip.downcase
        if (answ[0] == 'y')
          @balance -= amount
        end
      else
        @balance -= amount
      end
    else
      puts "Please withdraw a positive amount of money."
    end
    balance_inq
  end

  def gain_interest
    @balance = ((@balance.to_f * (100.0 + @@itr_rate)) / 100.0).round
  end

end

my_account = BankAccount.create

my_account.balance_inq
#
# puts my_account.balance
#
# puts my_account.deposit(90)
#
# puts my_account.withdraw(20)
#
# puts my_account.withdraw(80)
#
# puts my_account.withdraw(10_000.00)
#
# puts my_account.deposit(200_000.02)
#
# my_account.itr_rate = 1
#
# puts my_account.gain_interest
