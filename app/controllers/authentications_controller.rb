class AuthenticationsController < ApplicationController
  def index
    #@authentications = Authentication.all
    @authentications = current_user.authentications if current_user
    
  end

  def create
    # JDavis: one of the two should work
    #render :text => request.env["rack.auth"].to_yaml
    #render :text => request.env["omniauth.auth"].to_yaml
    #request.env["omniauth.auth"]
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successfull"
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
