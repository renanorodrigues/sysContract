class ReturnParamsDocumentService < ApplicationService

    def initialize(params_document, current_user)
        @user = current_user
        @params = params_document
    end

    def call
        return_params
    end

    private
    def return_params
        if @params[:document].has_key?("associateds_attributes")
           
            associateds = @params.dig(:document, :associateds_attributes, "0")
            associateds[:persona_id].delete("")
            array = []
            associateds[:persona_id].each {|key, x| array << {persona_id: key} }
            @params[:document][:associateds_attributes] = array
        else
            identification_users = params.dig(:document, :permissions_attributes, "0", :user_id)
            visibility_attr = params.dig(:document, :visibility_mode)
            id_document = params.dig(:id)
            array = []

            if identification_users == "Admins e Aprovadores"
                identification_users = ["Aprovador", "Administrador"]
            end

            User.where(profile: identification_users).ids.each {|x| array << {user_id: x, document_id: id_document}}
            
            params[:document][:permissions_attributes] = array

            list_params_allowed = [:visibility_mode, permissions_attributes:[:user_id, :document_id]]
        end
    end
end