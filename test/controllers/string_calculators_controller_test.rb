require "test_helper"

class StringCalculatorControllerTest < ActionDispatch::IntegrationTest
  test "should return the 0 in case of empty string" do
    get string_calculator_add_url, params: { numbers: "" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 0, response
  end

  # passing a string of comma-separated numbers
  test "should return the sum of numbers" do
    get string_calculator_add_url, params: { numbers: "1,2,3,4" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 10, response
  end

  test "should handle new line characters" do 
    get string_calculator_add_url, params: {numbers: "1\n2,3"}
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 6, response
  end

  test "should return sum with custom delimiter" do
    get string_calculator_add_url(numbers: "//;\n1;2;3")
    assert_response :success
    assert_equal "6", response.body
  end

  test "should return error for negative numbers" do
    get string_calculator_add_url(numbers: "1,-2,3,-4")
    assert_response :bad_request
    assert_includes response.body, "Error: Negative numbers not allowed: -2, -4"
  end
  
  test "should ignore numbers greater than 1000" do
    get string_calculator_add_url(numbers: "1,2,3,1001")
    assert_response :success
    assert_equal "6", response.body
  end

  test "should sum numbers when number is 1000" do
    get string_calculator_add_url(numbers: "1,2,3,1000")
    assert_response :success
    assert_equal "1006", response.body
  end

  test "should return sum when delimiter is of multiple length" do
    get string_calculator_add_url(numbers: "//[***]\n1***2***3")
    assert_response :success
    assert_equal "6", response.body
  end
end
