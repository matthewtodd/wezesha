class VcardsController < ApplicationController
  before_filter :user_sign_in_required
  before_filter :build_vcard, :only => [:new, :create]

  def create
    if @vcard.save
      respond_to do |format|
        format.xml  { render :xml => @vcard, :status => :created, :location => vcard_path(@vcard, :format => :xml) }
      end
    else
      respond_to do |format|
        format.xml  { render :xml => @vcard.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def build_vcard
    @vcard = current_user.vcards.build(params[:vcard])
  end
end
