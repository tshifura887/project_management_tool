require "test_helper"

class TeamAssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get team_assignments_create_url
    assert_response :success
  end
end
