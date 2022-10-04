# frozen_string_literal: true

class InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  prepend_before_action :authenticate_inviter!, only: %i[new create]
  prepend_before_action :has_invitations_left?, only: [:create]
  prepend_before_action :require_no_authentication, only: %i[edit update destroy]
  prepend_before_action :resource_from_invitation_token, only: %i[edit destroy]

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

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    resource.authorization_tier = 'user'
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: after_accept_path_for(resource)
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit, status: :unprocessable_entity }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invitate, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[first_name last_name])
  end
end
