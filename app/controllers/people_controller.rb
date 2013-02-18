class PeopleController < ApplicationController
  def index
# retrieve items from session
@items = session[:items]
# if no items arrray, create it
unless @items
@items = Array.new
end
# add the item sent by the form, if any, to the items array
if params[:item]
@items << params[:item]
end
# update the session items
session[:items] = @items
end
end
