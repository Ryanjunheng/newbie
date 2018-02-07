class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def create_from_omniauth
     auth_hash = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
     # if: previously already logged in with OAuth
     if authentication != nil
       user = authentication.user
       authentication.update_token(auth_hash)
       @notice = "Welcome back, " + user.name + "!"
     #elsif: user already has a normal account, but login via fb for the first time, this is to update his id in authentication.
    elsif (user = User.find_by(email: auth_hash['info']['email'])) != nil
        authentication = Authentication.create_with_omniauth(auth_hash)
        authentication.update(user_id: user.id)
     # else: user logs in with OAuth for the first time  
     else
      authentication = Authentication.create_with_omniauth(auth_hash)
       user = User.create_with_auth_and_hash(authentication, auth_hash)
       @notice = "Login via Facebook successfully"
     end

     sign_in(user)
     redirect_to "/" , :notice => @notice
   end

   alias_method :facebook, :create_from_omniauth
   alias_method :google_oauth2, :create_from_omniauth
   alias_method :passthru, :create_from_omniauth

end
