module Api
  module V1
    class UsersController < ApplicationController

      def index
        users = Users::ListUsers.new.call
        render json: users, each_serializer: Users::UserSerializer, status: :ok
      end

      def show
        user = Users::ShowUser.new(params[:id]).call
        if user
          render json: user, serializer: Users::UserSerializer, status: :ok
        else
          render json: { errors: 'User not found' }, status: :not_found
        end
      end

      def create
        user = Users::CreateUser.new(user_params).call
        render json: user, serializer: Users::UserSerializer, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

      def update
        result = Users::UpdateUser.new(params[:id], user_params).call

        case result[:status]
        when :not_found
          render json: { errors: 'User not found' }, status: :not_found
        when :unprocessable_entity
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        when :ok
          render json: result[:user], serializer: Users::UserSerializer, status: :ok
        end
      end

      def destroy
        user = Users::DestroyUser.new(params[:id]).call
        if user
          head :no_content
        else
          render json: { errors: 'User not found' }, status: :not_found
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :role, :name, :lastname, :phone)
      end
    end
  end
end