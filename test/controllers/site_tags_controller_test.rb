require 'test_helper'

class SiteTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site_tag = site_tags(:one)
  end

  test "should get index" do
    get site_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_site_tag_url
    assert_response :success
  end

  test "should create site_tag" do
    assert_difference('SiteTag.count') do
      post site_tags_url, params: { site_tag: {  } }
    end

    assert_redirected_to site_tag_url(SiteTag.last)
  end

  test "should show site_tag" do
    get site_tag_url(@site_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_tag_url(@site_tag)
    assert_response :success
  end

  test "should update site_tag" do
    patch site_tag_url(@site_tag), params: { site_tag: {  } }
    assert_redirected_to site_tag_url(@site_tag)
  end

  test "should destroy site_tag" do
    assert_difference('SiteTag.count', -1) do
      delete site_tag_url(@site_tag)
    end

    assert_redirected_to site_tags_url
  end
end
