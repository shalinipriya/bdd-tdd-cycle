Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

#Background: movies in database

#  Given the following movies exist:
#  | title        | rating | director     | release_date |
#  | Star Wars    | PG     | George Lucas |   1977-05-25 |
#  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
#  | Alien        | R      |              |   1979-05-25 |
#  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add director to existing movie
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Alien    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Star Wars        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  When I go to the edit page for "Star Wars"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Star Wars" should be "Ridley Scott"

Scenario: find movie with same director
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Alien    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Star Wars        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  And I am on the details page for "Alien"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Alien"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar movies if we don't know director (sad path)
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  And I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"
