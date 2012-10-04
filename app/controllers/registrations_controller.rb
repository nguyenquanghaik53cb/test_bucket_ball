class RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new :email => "test@test.com",:password => "password"
    @company = Company.new :name => "test"
    render "users/registrations/new"
  end
  
  def create
    @user = User.new params[:user]
    @user.build_company params[:company]
    if @user.save
      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(:user, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
        flash[:notice] = "welcome to our service please setting your company information."
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@user)
      end
    else
      clean_up_passwords @user
      respond_with @user
    end

  end

  def edit
  end

 protected
  def after_sign_up_path_for( user )
    edit_company_path()
  end
end
