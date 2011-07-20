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

  describe "get_page" do

    it "should response to get_page" do
      @HTML_paginator.should respond_to(:get_page)
    end
    
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

    it "should nil if input is empty" do
      empty_html_paginator = HTML_paginator.new("", 4)
      page = empty_html_paginator.get_page(1)
      page.should be_nil
    end
  end

  describe "print_page" do

    it "should respond to print_page" do
      @HTML_paginator.should respond_to(:print_page)
    end
    
  end

end
