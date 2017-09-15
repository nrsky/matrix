Feature: UploadRoutes
  Background:
    Given a route with id 123

  Scenario: Parsing data from a file
    When I make "POST" request to "/routes" with file "routes.json"
    Then I should get a "200" response
    And the response should contain the complex JSON:
      """
      {
        "total_count": 3
      }
      """





