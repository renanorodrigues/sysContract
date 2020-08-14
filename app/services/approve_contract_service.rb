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
        all_ids_admins_approvers = User.where(profile_id: [1,2]).ids
        all_admins_approvers = User.where(profile_id: [1,2]).count
        all_approvers = User.where(profile_id: 2).ids
        all_users_id = @contract.comments.pluck(:user_id)
        users_email = User.where(profile_id: [1,2]).pluck(:email)
        tot_comments = []
        tot_comments[0] = @contract.comments.where(status: true).count
        tot_comments[1] = @contract.comments.where(status: false).count

        # Analyst don't approve or disapprove contracts. Don't count.
        analyst_decision = @contract.comments.first
        if analyst_decision.status
          tot_comments[0] -= 1
        else  
          tot_comments[1] -= 1
        end

        if all_ids_admins_approvers.all? {|i| all_users_id.include?(i)}
          check_votes = true
        else
          check_votes = false
        end

        if check_votes
          if tot_comments[0] == all_admins_approvers
            @contract.update_attributes(:final_status => 'A')
          else
            if tot_comments[1] == all_admins_approvers
                @contract.update_attributes(:final_status => 'R')
            else
                @contract.update_attributes(:final_status => 'E')      
            end
          end
        end

        ApproveMailer.notify_approvers(@contract, users_email).deliver_now
    end
end