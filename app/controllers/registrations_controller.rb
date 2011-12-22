class RegistrationsController < Devise::RegistrationsController
  
  include Devise::Controllers::InternalHelpers

  def new
    super
  end

  def create
    build_resource 
    if resource.save   
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        # Create a subscription model at signup
        subscription = Subscription.new(:newsletter => params[:newsletter])
        subscription.user = resource
        subscription.save
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  def update
    super
  end
end