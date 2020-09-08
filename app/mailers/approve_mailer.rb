class ApproveMailer < ApplicationMailer
    helper :users_backoffice
    
    def analyst_approve(contract, users_email)
        @contract = contract
        @comment = contract.comments.first
        mail(to: users_email, subject: "Aval do contrato #{@contract.document.description} pelo analista.")
    end

    def new_document(document, emails)
        @document = document
        if document.file.attached? 
            filename = document.file.filename.extension_with_delimiter
            attachments[filename] = { mime_type: 'application/pdf', content: document.file.blob.download }
        end
        mail(to: emails, subject: "Novo documento adicionado!")
    end

    def expiration_contract(contract, emails)
        @contract = contract
        if @contract.document.file.attached? 
            filename = @contract.document.file.filename.extension_with_delimiter
            attachments[filename] = { mime_type: 'application/pdf', content: @contract.document.file.blob.download }
        end
        mail(to: emails, subject: "Vencimento de contrato")
    end

    def notify_users(contract, users_email)
        status = contract.status
        @contract = contract
        @comments = contract.comments

        mail(to: users_email, subject: "Novidades sobre o contrato de título #{@contract.document.description}.")
    end
end
