require 'html_paginator'

describe HTML_paginator do

  before(:each) do
    input = <<-EOM  
      <html>
        <div>
          <p>this is a 
            <a>long sentence</a> 
            that will be paginated
          </p>
        </div>
      </html>"
    EOM
    @HTML_paginator = HTML_paginator.new(input, 4)
  end

  describe "initialize" do
   
    it "should raise an ArgumentError exception if the page size is less then 1" do
      some_HTML = <<-html
      <html>
        <div>
          <p>some HTML</p>
        </div>
      <html>
      html
      lambda {HTML_paginator.new(some_HTML, 0)}.should raise_error(ArgumentError)
    end

    it "should raise an ArgumentError exception if the input is empty" do
      lambda {HTML_paginator.new("",1)}.should raise_error(ArgumentError)
    end

  end
  
  describe "get_page" do

    it "should return properly formed html with tags maintained for page 1" do
      page = @HTML_paginator.get_page(1)
      page.inner_html.should eq("<div><p>this is a<a>long</a></p></div>")
    end

    it "should return properly formed html with tags maintained for page 2" do
      page = @HTML_paginator.get_page(2)
      page.inner_html.should eql("<div><p><a>sentence</a> that will be</p></div>")
    end

    it "should return properly formed html with tags maintained for page 3" do
      page = @HTML_paginator.get_page(3)
      page.inner_html.should eql("<div><p>paginated</p></div>")
    end

    it "should raise an exception if an invalid page number is entered" do
      lambda {@HTML_paginator.get_page(0)}.should raise_error(InvalidPageNumber)
    end

  end

  describe "print_page" do

    it "should respond to print_page" do
      @HTML_paginator.should respond_to(:print_page)
    end
    
  end

end
