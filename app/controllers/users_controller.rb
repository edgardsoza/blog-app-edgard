class UsersController < ApplicationController
    def show
      # Placeholder logic or retrieve the user with the given ID from the database
      @user = User.find(params[:id])
    end
  end
  