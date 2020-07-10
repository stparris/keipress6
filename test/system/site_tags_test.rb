require "application_system_test_case"

class SiteTagsTest < ApplicationSystemTestCase
  setup do
    @site_tag = site_tags(:one)
  end

  test "visiting the index" do
    visit site_tags_url
    assert_selector "h1", text: "Site Tags"
  end

  test "creating a Site tag" do
    visit site_tags_url
    click_on "New Site Tag"

    click_on "Create Site tag"

    assert_text "Site tag was successfully created"
    click_on "Back"
  end

  test "updating a Site tag" do
    visit site_tags_url
    click_on "Edit", match: :first

    click_on "Update Site tag"

    assert_text "Site tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Site tag" do
    visit site_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Site tag was successfully destroyed"
  end
end
