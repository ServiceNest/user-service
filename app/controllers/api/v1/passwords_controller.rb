# frozen_string_literal: true

module Api
  module V1
    class PasswordsController < ApplicationController

      def verify
        verification_service = Users::PasswordVerificationService.new
        result = verification_service.verify(password_params[:email], password_params[:password])

        if result[:success]
          serialized_user = Users::UserSerializer.new(result[:user])
          render json: { user: serialized_user }, status: :ok
        else
          render json: { error: result[:error] }, status: :unauthorized
        end
      end

      def password_params
        params.permit(:email, :password)
      end
    end
  end
end
