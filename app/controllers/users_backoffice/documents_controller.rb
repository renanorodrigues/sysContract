class UsersBackoffice::DocumentsController < UsersBackofficeController
  def index
    @documents = Document.includes(:contract)
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
  end

  def create
    @document = Document.new(params_document)
    if @document.save
      AnalystApproveService.call(@document)
      redirect_to users_backoffice_documents_path, notice: "Documento cadastrado!"
    else
      render:new
    end
  end

  def edit
    @document.contract.build if @document.contract.blank?
  end

  def update
    if @document.update(params_document)  
      redirect_to users_backoffice_documents_path, notice: "Atualização feita com sucesso!"
    else
      render :edit 
    end
  end

  def show
    @comments = @document.contract
  end

  def destroy
    if @document.destroy
      redirect_to users_backoffice_documents_path, notice: "Remoção feita com sucesso!"
    else
      render :index
    end
  end

  private

    def set_document
      @document = Document.find(params[:id])
    end

    def params_document
      params_document = params.require(:document).permit(:description, :user_id, :type,:finality, contract_attributes: [ :id, :document_id, :salesman_name, :status, :price, :validation, :expiration])
    end
end
