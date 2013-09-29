require 'pp'

class Library

	def initialize(name)
		@name = name
		@num_of_shelves = 0
		@shelves = Hash.new
	end

    def addShelves(shelves)
        shelves.each{ |s| 
            @shelves[s.id] = s
            @num_of_shelves += 1
        }
    end

	def report_all_books()
		puts "***********************************"
		puts "#{@name} contains #{@num_of_shelves} shelves"
		@shelves.keys.sort.each{ |key| 
			shelf = @shelves[key]
			puts "--------------------"
			puts "Shelf " + shelf.id.to_s() + ":"
			puts "--------------------"
            puts shelf.report_books()

		}
		puts "***********************************"
	end
end

class Shelf

	attr_accessor :id

	def initialize(id)
        @books=Hash.new
        @id=id
	end

	def addBook(book)
		@books[book.id] = book
    end

    def removeBook(id)
    	@books.delete(id)
    end

    def report_books()
        PP.pp(@books)
    end
end

class Book

	attr_accessor :id

	def initialize(id,title,author)
		@id=id
		@title=title
		@author=author
		@shelf=nil
	end

	def enshelf(shelf)
		if(!@shelf.nil?)
            unshelf()
        end
        @shelf=shelf
        shelf.addBook(self)
	end

	def unshelf()
		@shelf.removeBook(@id)
		@shelf = nil
	end

	def to_s()
		"#{@id} - #{@title} by #{@author}"
	end
end


library = Library.new("Seattle Public Library")
s1 = Shelf.new(1)
s2 = Shelf.new(2)
s3 = Shelf.new(3)
b1 = Book.new(1,"A Tale of Two Cities","Charles Dickens")
b2 = Book.new(2,"The Lord of the Rings","J.R.R. Tolkien")
b3 = Book.new(3,"Watership Down","Richard Adams")
b4 = Book.new(4,"Think and Grow Rich","Napoleon Hill")
b1.enshelf(s1)
b2.enshelf(s1)
b3.enshelf(s2)
b4.enshelf(s2)
library.addShelves([s1,s2])
library.report_all_books()

puts "Test Removing #{b1}"
b1.unshelf()

library.report_all_books()

puts "Test moving #{b4} to #{s1}"
b4.enshelf(s1)

library.report_all_books()



