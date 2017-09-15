@vcr
Feature: DownloadRoutes

  Scenario: Creating a route with correct data
    When I make "GET" request to "/routes":
    """
      {
        "source":"loopholes",
        "passphrase":"Kans4s-i$-g01ng-by3-bye"
      }
   """
    Then I should get a "201" response
    And  the response should contain the complex JSON:
    """
      [
        {
          "start_node":"gamma",
          "end_node":"theta",
          "node_pair_id":"1",
          "route_id":"1",
          "start_time":"2030-12-31T13:00:04.000Z",
          "end_time":"2030-12-31T13:00:05.000Z"
        },
        {
          "start_node":"beta",
          "end_node":"theta",
          "node_pair_id":"2",
          "route_id":"2",
          "start_time":"2030-12-31T13:00:05.000Z",
          "end_time":"2030-12-31T13:00:06.000Z"
        },
        {
         "start_node":"theta",
         "end_node":"lambda",
         "node_pair_id":"3",
         "route_id":"2",
         "start_time":"2030-12-31T13:00:06.000Z",
         "end_time":"2030-12-31T13:00:07.000Z"
        }
      ]
    """
