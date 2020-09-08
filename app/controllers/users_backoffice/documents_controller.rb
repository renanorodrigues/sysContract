class UsersBackoffice::DocumentsController < UsersBackofficeController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    console
    @documents = ReturnDocumentsService.call(current_user)
    respond_to do |format|
      format.html
      format.pdf
      format.xlsx do 
        filename = GenerateXLSXService.call(@documents)
        send_data(File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename)
      end
    end
  end

  def new
    @document = Document.new
    @document.build_contract
    @document.associateds.build
  end

  def create
    #@document = Document.new(params_document)
    if @document.save
      SentDocumentService.call(@document)
      redirect_to users_backoffice_documents_path, notice: "Documento cadastrado!"
    else
      render:new
    end
  end

  def edit
    if @document.type_document == "Contrato"
      @document.build_contract 
    end
  end

  def update
    #@document = Document.new(params_document)
    if @document.update(params_document)  
     redirect_to users_backoffice_documents_path, notice: "Atualização feita com sucesso!"
    else
     render :index
    end
  end

  def show
  end

  def destroy
    if @document.destroy
      redirect_to users_backoffice_documents_path, notice: "Remoção feita com sucesso!"
    else
      render :index
    end
  end

  def visibility_configuration
    @document = Document.find(params[:document_id])
    @document.permissions.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def set_document
      @document = Document.find(params[:id])
    end

    def params_document
      ReturnParamsDocumentService.call(params, current_user)
      params_document = params.require(:document).permit(:description, :finality, :type_document, :file, associateds_attributes:[:persona_id], contract_attributes:[:price, :persona_id, :validation, :expiration])
    end
end
