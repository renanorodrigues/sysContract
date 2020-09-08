class ApproveContractService < ApplicationService
    attr_reader :contract 

    def initialize(contract)
        @contract = contract
    end

    def call
      counting_votes
    end

    private

    def counting_votes
      if checking_votes
        users_email = User.where(profile: ["Administrador", "Aprovador"]).pluck(:email)
        all_ids_admins_approvers = User.where(profile: ["Administrador", "Aprovador"]).ids
        tot_votes = {}
        tot_votes[:approvers] = @contract.comments.where(decision: true, user_id: all_ids_admins_approvers).count
        tot_votes[:disapprovers] = @contract.comments.where(decision: false, user_id: all_ids_admins_approvers).count

        if all_ids_admins_approvers.count == tot_votes[:approvers]
          @contract.update_attribute(:status, "A")
        elsif all_ids_admins_approvers.count == tot_votes[:disapprovers]
          @contract.update_attribute(:status, "R")
        end

        ApproveMailer.notify_users(@contract, users_email).deliver_now
      end
    end

    def checking_votes
        all_ids_admins_approvers = User.where(profile: ["Administrador", "Aprovador"]).ids
        all_users_id = @contract.comments.pluck(:user_id)

        # Analyst and Lawyer don't approve or disapprove contracts. Don't count.
        if all_ids_admins_approvers.all? {|i| all_users_id.include?(i)}
          true
        else
          false
        end
    end
end