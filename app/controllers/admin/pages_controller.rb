class Admin::PagesController < Admin::ApplicationController
  before_filter :administrator_sign_in_required
end
