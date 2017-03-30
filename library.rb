class Book

  @@on_shelf = []
  @@on_loan = []

  book_number = Random.new

  def self.create(title, author, isbn)
    @@on_shelf << Book.new(title, author, isbn)
    @@on_shelf[-1]
    @@index = 0
  end

  def self.current_due_date
    Time.now + (2 * 7 * 24 * 3600) # 2 weeks
  end

  def self.overdue_books

  end

  def self.browse
    if (@@on_shelf > 0)
      return @@onshelf[book_number.rand(@@on_shelf.length)]
    else
      puts "Sorry, there are no books on shelf."
    end
  end

  def self.available
    @@on_shelf
  end

  def self.borrowed
    @@on_loan
  end

###########################################

  attr_accessor :due_date
  attr_reader :uuid

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
    @@index += 1
    @index = @@index
  end

  def borrow
    if (lent_out)
      return false
    else
      @@on_loan << self
      @@on_shelf.delete(self)
      @due_date = current_due_date
      return true
    end
  end

  def return_to_library
    if (lent_out)
      @@on_shelf << self
      @@on_loan.delete(self)
      @due_date = nil
      return true
    else
      return false
    end
  end

  def lent_out?
    @@on_loan.include?(self)
  end

  def overdue
    overdue_books = []
    @@on_loan.each do |book|
      if (Time.now > @due_date)
        overdue_books << book
      end
    end
    overdue_books
  end





end
