# Welcome to Ruby Api Error Responser
 handle your exceptions elegantly with this module.

## Usage
1. load the file where you want to use. 
2. call the methods!
3. examples
```ruby
class Api::PostsController < ApplicationController
  def index
    return invalid_json if json_checker_says_no
    # and this will response
    # {"code":"400-00","error":"InvalidJson","description":"The request body is not a valid JSON document."}
  end
end
```
Enjoy!

License: MIT

