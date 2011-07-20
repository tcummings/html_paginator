#!/usr/bin/env ruby -w
require '../lib/html_paginator'

input = <<-EOM
  <html>
    <div>
      <p>this is a 
        <a>long sentence</a> 
        that will be paginated
      </p>
    </div>
  </html>
EOM

paginator = HTML_paginator.new(input,4)
paginator.print_page(1)
paginator.print_page(2)
paginator.print_page(3)
