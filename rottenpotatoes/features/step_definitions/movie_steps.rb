# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
    step %Q{I should see "#{movie}"}
    step %Q{I should see "#{director}"}
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.should have_content(/#{e1}.*#{e2}/)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(" ").each do |ratings|
    step "I #{uncheck}check \"ratings_#{ratings}\""
  end
    
end

When /I should (not )?see the following movies: (.*)/ do |shouldnot, movie_list|
  movie_list.split(", ").each do |movies|
    step "I should #{shouldnot}see #{movies}"
  end
    
end

Then /I should see all the movies/ do 
  page.all(:css, "movies tr").count == 10
end