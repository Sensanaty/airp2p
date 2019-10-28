require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get overview" do
    get dashboards_overview_url
    assert_response :success
  end

end
