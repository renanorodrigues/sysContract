class NotifyExpirationService < ApplicationService
    attr_reader :contract

    def initialize(contract)
        @contract = contract
    end

    def call
        send_notification
    end

    private

    def send_notification
        if verify_expiration
            all_approvers_emails = User.where(profile: "Aprovador").pluck(:email)
            all_associateds = @contract.document.associated_ids
            all_personas_ids = Associated.where(id: all_associateds).pluck(:persona_id)
            all_emails = Persona.find(all_personas_ids).pluck(:email)
            all_approvers_emails.each {|e| all_emails << e}
            ApproveMailer.expiration_contract(@contract, all_emails).deliver_now
        end
    end

    def verify_expiration
        date_now = Date.today
        #date_about_7_days = date_now - 7.days
        contract_date_expiration = @contract.expiration.strftime("%d-%m-%Y")
        if contract_date_expiration == date_now.strftime("%d-%m-%Y")
            true
        else
            false
        end
    end
end