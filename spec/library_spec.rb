require "spec_helper"

describe "Library object" do
# creates array of books and adds to YAML file BEFORE the tests run
  before :all do
    lib_obj = [
      Book.new("Javascript: The Good Parts", "Douglas Crockford", :development),
      Book.new("Designing with Web Standards", "Jeffery Zeldman", :design),
      Book.new("Don't Make Me Think", "Steve Krug", :usability),
      Book.new("Javascript Patterns", "Stoyan Stefanov", :development),
      Book.new("Responsive Web Design", "Ethan Marcotte", :design)
    ]
    File.open "books.yml", "w" do |f|
      f.write YAML::dump lib_obj
    end
  end

  before :each do
    @lib = Library.new "books.yml"
  end

# tests
  describe "#new" do
    context "with no parameters" do
      it "has no books" do
        lib = Library.new
        lib.should have(0).books
      end
    end
    context "with a yaml file parameter" do
      it "has five books" do
        @lib.should have(5).books
      end
    end
  end

  it "returns all the books in a given category" do
    @lib.get_books_in_category(:development).length.should == 2
  end

  it "accepts new books" do
    @lib.add_book( Book.new("Designing for the Web", "Mark Boulton", :design))
    @lib.get_book("Designing for the Web").should be_an_instance_of
  end

  it "saves the library" do
    books = @lib.books.map {|book| book.title}
    @lib.save
    lib2 = library.new "books.yml"
    books2 = lib2.books.map {|book| book.title}
    books.should == books2
  end
#end of library object test
end
