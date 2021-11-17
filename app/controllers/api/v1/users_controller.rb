class Api::V1::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :find_user, only: [:show, :update, :destroy]

    def index
        @user = User.all
        render json: {status: 'SUCCESS', message:'Loaded users', data: @user},status: :ok
    end

    def show
        render json: {status: 'SUCCESS', message:'Loaded users', data: @user},status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: {status: 'SUCCESS', message:'Saved user', data: @user},status: :ok
        else
            render json: {status: 'ERROR', message:'user not saved', data: @user.errors},status: :ok
        end
    end
    def update
        if @user
            @user.update(user_params)
            render json: {status: 'SUCCESS', message:'Updated User', data: @user},status: :ok
        else
            render json: {status: 'ERROR', message:'User not updated', data: @user.errors},status: :ok
        end
    end
    def destroy
        if @user
            @user.destroy
            render json: {status: 'SUCCESS', message:'destory user', data: @user},status: :ok
        else
            render json: {status: 'ERROR', message:'user not destroy', data: @user.errors},status: :ok
        end
    end
    
     private
    
     def find_user
        @user = User.find(params[:id])
     end

     def user_params
        params.require(:user).permit(:username, :password)
     end
  
end

