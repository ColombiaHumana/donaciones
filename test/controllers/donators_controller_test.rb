require 'test_helper'

class DonatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donator = donators(:one)
  end

  test "should get index" do
    get donators_url
    assert_response :success
  end

  test "should get new" do
    get new_donator_url
    assert_response :success
  end

  test "should create donator" do
    assert_difference('Donator.count') do
      post donators_url, params: { donator: { amount: @donator.amount, doc_image: @donator.doc_image, doctype: @donator.doctype, document: @donator.document, firstname: @donator.firstname, lastname: @donator.lastname, rut_image: @donator.rut_image } }
    end

    assert_redirected_to donator_url(Donator.last)
  end

  test "should show donator" do
    get donator_url(@donator)
    assert_response :success
  end

  test "should get edit" do
    get edit_donator_url(@donator)
    assert_response :success
  end

  test "should update donator" do
    patch donator_url(@donator), params: { donator: { amount: @donator.amount, doc_image: @donator.doc_image, doctype: @donator.doctype, document: @donator.document, firstname: @donator.firstname, lastname: @donator.lastname, rut_image: @donator.rut_image } }
    assert_redirected_to donator_url(@donator)
  end

  test "should destroy donator" do
    assert_difference('Donator.count', -1) do
      delete donator_url(@donator)
    end

    assert_redirected_to donators_url
  end
end
