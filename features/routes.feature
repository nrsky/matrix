@vcr
Feature: DownloadRoutes

  Scenario: Downloads and processes
    When I make "GET" request to "/routes":
    """
      {
        "source":"loopholes",
        "passphrase":"Kans4s-i$-g01ng-by3-bye"
      }
    """
    Then I should get a "200" response
    And  the response should contain the complex JSON:
    """
     {"count": 3}
    """