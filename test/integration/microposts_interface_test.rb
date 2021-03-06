require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @np = nonprofits(:np1)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This micropost really ties the room together"
    np = @np.id
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content, nonprofit_id: np }
    end
    
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    
    # Visit a different user - need to get this test set up with a non-profit
    path = user_path(users(:archer), :nonprofit_name => "Teton Raptor Center")

     get path
    assert_select 'a', text: 'delete', count: 0
  end
end 
