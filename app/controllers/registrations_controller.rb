class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted? && @user.send_email == true
      ForecastMailer.welcome_email(@user).deliver
    end
  end

 private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :zip, :phone_number, :send_email, :send_text)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confimation,
                                 :current_password, :zip, :phone_number,
                                 :send_email, :send_text)
  end
end
