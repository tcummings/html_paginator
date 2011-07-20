require 'nokogiri'

# Summary:html_paginator will paginate html based on the page_size.
#         All html tags will be maintained from the original html structure
#
# Author: Theo Cummings
class HTML_paginator

  public
  def initialize(input,page_size)
    @html = Nokogiri::HTML(input)
    @page_size = page_size > 0 ? page_size : 1 #page_size must be greater then 0
    @total_words_count = @html.text().split(/\s+/).size
    # @total_pages should account for partial pages
    @total_pages = (@html.text().split(/\s+/).size/(@page_size*1.0)).ceil
  end

  def get_page(page_number)
    # only allow valid page numbers 1 - total pages
    if page_number < 1 then 
      page_number = 1
    elsif page_number > @total_pages then 
      page_number = @total_pages
    end
    #make a copy of the source so we do not modify the original
    doc = Nokogiri::HTML(@html.to_s)
    format_HTML(doc.at_css('body'),page_number) 
  end

  def print_page(page_number)
    begin
      puts "Page #{page_number}: #{get_page(page_number).inner_html}"
    rescue => e
      puts "No HTML was returned for page #{page_number}."
    end
  end

  private
  def format_HTML(html,page_number)
    # calculate start and end indexes of the page
    page_end = @page_size * page_number 
    page_begin = (page_end - @page_size)+1
    
    # a work index to track our current place in the text
    word_index = 0
    # gurantee the end index does not pass the end of the text
    if page_end > @total_words_count then page_end = @total_words_count end
    
    begin
     html.css('text()').each do |text_node|
      result = []
      text_node.text.split(/\s+/).each do |word|
        # do not increment the word index when an emtpy string occurs
        word_index+=1 unless word.empty?
        if (page_begin..page_end).include?(word_index) then result << word end
      end
      if result.empty? then
        cleanup_node(text_node)
      else
        text_node.content = result.join(" ").to_s
      end
     end
     rescue => e
      puts "Rescue exception: #{e.message}, TRACE:#{$@}"
    end
    return html
  end
  
  def cleanup_node(node)
    current_parent = node.parent
    node.remove
    #clean up empty parent nodes if they have no children.
    until current_parent.children.size > 0 do
      next_parent = current_parent.parent
      current_parent.remove
      current_parent = next_parent
    end
  end

end
