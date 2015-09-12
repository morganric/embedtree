
class Users::RegistrationsController < Devise::RegistrationsController


before_action :permit_invite_code

def permit_invite_code
  devise_parameter_sanitizer.for(:sign_up) << :invite_code
end

end