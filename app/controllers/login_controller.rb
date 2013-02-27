class LoginController < ApplicationController
def login
@previous_memory_name = cookies[:stored_name]
@memory_name = params[:input_name]
cookies[:stored_name] = @memory_name
end
end
