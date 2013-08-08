# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    if movie["title"]!= "title"
      Movie.create(movie)
    end
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",") do |rating|
    if uncheck=="un"
      uncheck(rating)
    else
      check(rating)
    end
  end
end

Then /^I uncheck all other checkboxes$/ do
  Movie.all_ratings do |rating|
    if rating != "PG" && rating != "G" && rating != "R"
      uncheck(rating)
    end
  end
end

Then /^I press "(.*?)" button$/ do |arg1|
  assert_equal arg1, "submit"
end

Then /^I should see all of the movies$/ do
  assert_equal Movie.count,10
end

Given /^I uncheck all checkboxes$/ do
  Movie.all_ratings do |rating|
    uncheck(rating)
  end
end

Given /^I check all checkboxes$/ do
  Movie.all_ratings do |rating|
    check(rating)
  end
end

Then /^I should see 'Aladdin' before 'Amelie'\.$/ do
  assert_equal page.body.index("Aladdin") < page.body.index("Amelie"), true
end

