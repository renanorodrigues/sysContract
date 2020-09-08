class ReturnDocumentsService < ApplicationService
    attr_reader :current_user

    def initialize(current_user)
        @user = current_user
    end

    def call 
        return_documents
    end

    private

    def return_documents 
        documents_permitted = Permission.where(user_id: @user).pluck(:document_id) 
        @documents = Document.where(visibility_mode: "G").or(Document.where(id: documents_permitted))
        
        return @documents
    end
end