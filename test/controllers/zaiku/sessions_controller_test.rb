require 'test_helper'

module Zaiku
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "a person is redirect to the ZAIKU directory OAuth flow" do
      get new_session_url

      params = {
        client_id: ZAIKU::Directory.client_id,
        redirect_uri: new_callback_url,
        response_type: 'code'
      }

      assert_redirected_to "#{Zaiku.approve_zaiku_session_path}/oauth/authorize?#{params.to_query}"
    end
  end
end
