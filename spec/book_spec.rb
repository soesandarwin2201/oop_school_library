require './book'

describe Book do 
 context "Test the book class" do
  it "Test the attribute of the book class" do
   title = '10x rule'
   author = 'soe'

   book = Book.new(title,author)
   expect(book.title).to eq '10x rule'
   expect(book.author).to eq 'soe'
   expect(book.rentals).to eq []
  end
 end
end