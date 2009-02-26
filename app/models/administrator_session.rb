class AdministratorSession < Authlogic::Session::Base
  find_with :session, :cookie, :api_key

  def valid_api_key?
    controller.authenticate_with_http_basic do |api_key, _|
      self.unauthorized_record = search_for_record("find_by_#{single_access_token_field}", api_key)
      self.persisting = false
      self.valid?
    end.tap do |authenticated|
      self.persisting = true unless authenticated
    end
  end
end