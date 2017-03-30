class BankAccount
  def balance
    if (@balance.class != Integer)
      @balance = 0
    end
    if (@balance < -1_000_000)
      puts "The debt collectors are coming!"
    elsif(@balance < 0)
      puts "Your account is overdrawn!"
    elsif(@balance > 1_000_000)
      puts "Thanks for being a valued customer!"
    end
    (@balance.to_f / 100.0).round(2)
  end

  attr_accessor :itr_rate

  def deposit(amount)
    self.balance
    amount = (amount * 100).to_i
    if (amount > 0)
      @balance += amount
    else
      puts "Please deposit a positive amount of money."
    end
    self.balance
  end

  def withdraw(amount)
    self.balance
    amount = (amount * 100).to_i
    if (amount > 0)
      if (amount > @balance)
        puts "You have a balance of only $#{self.balance}. Are you sure? (y/N)"
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
    self.balance
  end

  def gain_interest
    self.balance
    @balance = (@balance * (100 + itr_rate.to_i)) / 100
    self.balance
  end

end

my_account = BankAccount.new

puts my_account.balance

puts my_account.deposit(90)

puts my_account.withdraw(20)

puts my_account.withdraw(80)

puts my_account.withdraw(10_000.00)

puts my_account.deposit(200_000.02)

my_account.itr_rate = 1

puts my_account.gain_interest
