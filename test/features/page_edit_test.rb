require './test/test_helper'

class PageEditTest < FeatureTest
  def test_it_edits_a_page
  	page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}

    # Create a page
    returned_page = Page.create( page_data )
    # Visit it and make sure the content is there
    get "/pages/#{page_data[:slug]}"

    assert_page_has page_data[:content]

    # Click an EDIT link on that page
    visit "/pages/about-us"
    assert_page_has "edit"
    click_link "edit"
  #   # Change the content via the form
  	assert page.has_content?("Edit Page")
    fill_in('page[slug]', :with => 'Edited slug')
		fill_in('page[content]', :with => 'Edited content')

  # #   # Submit the form
  #assert page.has_content?("submit"), "cannot find submit"
    click_button 'submit'
  # #   # Verify that you're back to the article and "see" the updated content
   	assert page.has_content?('Edited content')
  end
end
