# frozen_string_literal: true

class InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  prepend_before_action :authenticate_inviter!, only: %i[new create]
  prepend_before_action :has_invitations_left?, only: [:create]
  prepend_before_action :require_no_authentication, only: %i[edit update destroy]
  prepend_before_action :resource_from_invitation_token, only: %i[edit destroy]
  skip_before_action :authorize!, except: %i[new create]
  grant(
    user: %i[edit update destroy],
    manager: :all,
    admin: :all
  )

  def new
    self.resource = resource_class.new
    render :new
  end

  def create
    self.resource = invite_resource
    resource.authorization_tier = 'user'
    resource.invited_by_id = current_inviter.id
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: resource.email
      end
      if method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invitate, keys: %i[first_name last_name manager_id])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[first_name last_name manager_id])
  end
end
