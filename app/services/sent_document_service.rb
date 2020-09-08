class SentDocumentService < ApplicationService
    attr_reader :document

    def initialize(document)
        @document = document
    end

    def call  
        sent_document
    end

    private
    def sent_document
        users_email = User.where(profile: ["Administrador", "Aprovador", "Analista", "Advogado"]).pluck(:email)
        ApproveMailer.new_document(@document, users_email).deliver_now
    end
end