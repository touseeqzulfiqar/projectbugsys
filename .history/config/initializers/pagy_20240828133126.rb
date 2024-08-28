# config/initializers/pagy.rb

# Pagy initializer file
require 'pagy/extras/bootstrap' # Add Bootstrap pagination
# require 'pagy/extras/overflow'   # To handle overflow pages (e.g., for handling out-of-bound pages)

Pagy::DEFAULT[:items] = 10 # Default number of items per page
Pagy::DEFAULT[:size]  = [1, 4, 4, 1] # Example for [left outer, left inner, right inner, right outer] sizes
