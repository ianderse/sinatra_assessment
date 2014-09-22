require './test/test_helper'

class PageTest < Minitest::Test
  def test_it_stores_a_page
    page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}

    returned_page = Page.create( page_data )
    found_page    = Page.find_by_slug( page_data[:slug] )

    assert_equal returned_page, found_page
    assert_equal page_data[:slug], found_page.slug
    assert_equal page_data[:content], found_page.content
  end

  def test_it_returns_all_pages
  	page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}
    page_data_2 = {:slug => "contact",
                   :content => "Call us at 111-222-3333"}

    returned_page = Page.create( page_data )
    second_page   = Page.create( page_data_2 )
    found_page    = Page.all.first

    assert_equal returned_page, found_page
    assert_equal page_data[:slug], found_page.slug
    assert_equal page_data[:content], found_page.content
    assert_equal 2, Page.all.size
  end

  def test_it_can_delete_a_page
  	page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}
    page_data_2 = {:slug => "contact",
                   :content => "Call us at 111-222-3333"}

    returned_page = Page.create( page_data )
    second_page   = Page.create( page_data_2 )
    Page.destroy(page_data[:slug])
    assert_equal 1, Page.all.size
  end

  def test_it_can_update_a_page
    page_data = {:slug    => "about-us",
                 :content => "Our site is great!"}
    updated_data = {:slug  => "edited slug",
                    :content => "edited content"}

    returned_page = Page.create( page_data )
    Page.update(page_data[:slug], updated_data)
    found_page = Page.find_by_slug( updated_data[:slug] )

    assert_equal updated_data[:content], found_page.content

  end

end
