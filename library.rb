class Book

  @@on_shelf = []
  @@on_loan = []
  @@index = 0
  @@book_number = Random.new

  def self.create(title, author, isbn)
    @@on_shelf << Book.new(title, author, isbn)
    @@on_shelf[-1]
  end

  def self.current_due_date
    Time.now + (2 * 7 * 24 * 3600) # 2 weeks
  end

  def self.overdue
    overdue_books = []
    @@on_loan.each do |book|
      if (Time.now > book.due_date)
        overdue_books << book
      end
    end
    overdue_books
  end

  def self.genre_list(genre)
    book_list = []
    @@on_shelf.each do |book|
      book_list << book if book.genre == genre
    end
  end

  def self.browse(genre = :any)
    if (genre == :any)
      if (@@on_shelf.length > 0)
        return @@on_shelf[@@book_number.rand(@@on_shelf.length)]
      else
        puts "Sorry, there are no books on shelf."
      end
    else
      book_list = Books.genre(genre)
      if (book_list.length > 0)
        return book_list[@@book_number.rand(book_list.length)]
      else
        puts "Sorry, there are no books on shelf in the #{genre.to_s} section."
      end
    end
  end

  def self.available
    @@on_shelf
  end

  def self.borrowed
    @@on_loan
  end

  def self.match(key, value, availability = :any)
    matches = []
    unless (availability == :on_loan)
      @@on_shelf.each do |book|
        case key
        when key == :title
          matches << book if book.title == value
        when key == :author
          matches << book if book.author == value
        when key == :genre
          matches << book if book.genre == value
        when key == :isbn
          matches << book if book.isbn == value
        end
      end
    end
    unless (availability == :on_shelf)
      @@on_loan.each do |book|
        case key
        when key == :title
          matches << book if book.title == value
        when key == :author
          matches << book if book.author == value
        when key == :genre
          matches << book if book.genre == value
        when key == :isbn
          matches << book if book.isbn == value
        end
      end
    end
  end

###########################################

  attr_accessor :due_date
  attr_reader :index
  attr_reader :genre
  attr_reader :isbn
  attr_reader :title
  attr_reader :author

  def initialize(title, author, isbn, genre = :unspecified)
    @title = title
    @author = author
    @isbn = isbn
    @@index += 1
    @index = @@index
    @on_hold = false
    @genre = genre
  end

  def borrow
    if (lent_out?)
      @on_hold = true
      return false
    else
      @@on_loan << self
      @@on_shelf.delete(self)
      @due_date = Book.current_due_date
      return true
    end
  end

  def renew
    if (lent_out?)
      if (!@on_hold)
        @due_date += (7 * 24 * 3600) # 1 week
        return true
      end
    else
      return false
    end
  end

  def return_to_library
    if (lent_out?)
      @@on_shelf << self
      @@on_loan.delete(self)
      @due_date = nil
      if @on_hold
        puts "#{@title} has just been returned!"
        @on_hold = false
      end
      return true
    else
      return false
    end
  end

  def lent_out?
    @@on_loan.include?(self)
  end
end

sister_outsider = Book.create("Sister Outsider", "Audre Lorde", "9781515905431")
aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", "9780896081307")
if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", "0893880221")
puts Book.browse.inspect # #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.available.inspect # [#<Book:0x00555e82acde20 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431">, #<Book:0x00555e82acdce0 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # []
puts sister_outsider.lent_out? # false
puts sister_outsider.borrow # true
puts sister_outsider.lent_out? # true
puts sister_outsider.borrow # false
puts sister_outsider.due_date # 2017-02-25 20:52:20 -0500 (this value will be different for you)
puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # [#<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=2017-02-25 20:55:17 -0500>]
puts Book.overdue.inspect # []
puts sister_outsider.return_to_library # true
puts sister_outsider.lent_out? # false
puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">, #<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=nil>]
puts Book.borrowed.inspect # []
