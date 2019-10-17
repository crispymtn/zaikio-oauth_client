require_dependency "zaiku/application_controller"

module Zaiku
  class SessionsController < ApplicationController
    def new
      cookies.encrypted[:origin] = params[:origin]
      redirect_to oauth_client.auth_code.authorize_url(redirect_uri: approve_zaiku_sessions_url)
    end

    def approve
      access_token = oauth_client.auth_code.get_token(params[:code])
      response = access_token.get('/api/v1/person')
      zaiku_data = JSON.parse(response.body)

      if person = ZAIKU::Directory.person_class.find_or_create_from_zaiku(zaiku_data)
        person.save_access_token(access_token)

        Current.user = person
        cookies.encrypted[:person_id] = person.id
      end

      redirect_to(cookies.encrypted[:origin] || '/')
      cookies.delete :origin
    end
  end
end
