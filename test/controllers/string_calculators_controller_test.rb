require "test_helper"

class StringCalculatorControllerTest < ActionDispatch::IntegrationTest
  # passing a string of comma-separated numbers
  test "should return the sum of numbers" do
    get string_calculator_add_url, params: { numbers: "1,2,3,4" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 10, response
  end
end
