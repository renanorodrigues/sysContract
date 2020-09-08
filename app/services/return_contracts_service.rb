class ReturnContractsService < ApplicationService
    attr_reader :current_user

    def initialize(current_user)
        @user = current_user
    end

    def call
        return_contracts
    end

    private

    def return_contracts
        only_documents_permitted = Permission.where(user_id: @user).pluck(:document_id)    
        @contracts = Contract.where(document_id: only_documents_permitted)
        return @contracts
    end
end