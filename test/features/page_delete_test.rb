require './test/test_helper'

class PageDeleteTest < FeatureTest
  def test_it_deletes_a_page
    page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}
    page_data_2 = {:slug => "contact",
                   :content => "Call us at 111-222-3333"}

    # Create two pages in the database
    returned_page = Page.create( page_data )
    second_page   = Page.create( page_data_2 )
		# Make a delete request to delete one of them
    Page.destroy(page_data[:slug])
    # Make sure the deleted one is gone (404)
    deleted_page  = Page.find_by_slug( page_data[:slug] )
    get "/pages/#{page_data[:slug]}"
    assert_equal 404, last_response.status
    # Make sure the other one is still there
    found_page    = Page.find_by_slug( page_data_2[:slug] )
    assert_equal second_page, found_page
  end
end
