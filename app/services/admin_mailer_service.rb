class AdminMailerService < ApplicationService
    
    def initialize(admin, user)
        @current_admin = admin
        @user_updated = user
    end

    def call
        if @current_admin.profile_id = 1 && @current_admin.id != @user_updated.id
            AdminMailer.update_bio(@current_admin, @user_updated).deliver_now
        end
    end
end