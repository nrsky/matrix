Feature: UploadRoutes
  Background:
    Given a route with source "loopholes"
  Scenario: Prepares routes from DB to be uploaded
    When I make send "POST" request to "/routes":
    """
        {
        "source":"loopholes",
        "passphrase":"Kans4s-i$-g01ng-by3-bye"
        }

    """
    Then I should get a "200" response
    And  the response should contain the complex JSON:
    """
      [
       {
         "source":"loopholes",
         "passphrase":"Kans4s-i$-g01ng-by3-bye",
         "start_node":"beta",
         "end_node":"alpha",
         "start_time":"2017-09-25T11:55:29Z",
         "end_time":"2017-09-25T11:56:29Z"
        }
      ]
    """

