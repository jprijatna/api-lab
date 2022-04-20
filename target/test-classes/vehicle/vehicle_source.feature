Feature: vehicle_source

  Background: calling vehicle regos
    Given url 'http://localhost:8500'
    Given path '/data/regos'
    When method GET
    Then status 200
    * def dataInput = response.data
    * def data = karate.map(dataInput, function(value, index) { return { RegistrationNumber: value} })

  Scenario Outline: success
    Given path '/data/<RegistrationNumber>'
    When method GET
    Then status 200
    Examples:
      | data |


  Scenario Outline: invalid registration
    Given path '/data/<!RegistrationNumber>'
    When method GET
    Then status 404
    And match response ==
    """
      {
        "message": "No vehicle found!"
      }
    """
    Examples:
      | data |

  Scenario: other cases
    Given path '/'
    When method GET
    Then status 502