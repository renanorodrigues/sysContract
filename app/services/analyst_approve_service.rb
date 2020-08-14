class AnalystApproveService < ApplicationService
    attr_reader :contract

    def initialize(contract)
        @contract = contract
    end

    def call
        if check_approve_analista
            users_email = User.where(profile_id: [1,2]).pluck(:email)
            ApproveMailer.analyst_approve(@contract, users_email).deliver_now
        else
            analysts_email = User.where(profile_id: 3).pluck(:email)
            ApproveMailer.new_contract(@contract, analysts_email).deliver_now
        end
    end

    private

    def check_approve_analista
        if @contract.comments.blank?
            false
        else
            analista = @contract.comments.first.user
            if analista.profile_id == 3
                analista_comment = contract.comments.first
                if analista_comment.status == true 
                    true
                end
            end    
        end
    end
end