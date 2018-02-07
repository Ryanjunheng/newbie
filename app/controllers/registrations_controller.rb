class RegistrationsController < Devise::RegistrationsController

	private 

	# sign up params to overwrite default devise default params without the name attr.
	def sign_up_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	# user update params to overwrite devise default params.
	def account_update_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
	end

end