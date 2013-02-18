class LoginController < ApplicationController
  def login
  	@previous_name = cookies[:stored_name]
	@name = params[:input_name]
	cookies[:stored_name] = @name
  end
end
