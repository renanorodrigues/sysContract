class UsersBackoffice::ContractsController < UsersBackofficeController
  before_action :set_contract, only: [:edit, :show, :update, :destroy]

  def index
    console
    @contracts = ReturnContractsService.call(current_user)
    respond_to do |format|
      format.html
      format.pdf
      format.xlsx do 
        filename = GenerateXLSXService.call(@contracts)
        send_data(File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename)
      end
    end
  end

  def new
    @contract = Contract.new
    @contract.comments.build
  end

  def create
    @contract = Contract.new(params_contract)
    if @contract.save
      #ApproveContractService.call(@contract)
      redirect_to users_backoffice_contracts_path, notice: "Contrato cadastrado!"
    else
      render:new
    end
  end

  def edit
    @contract.comments.build if @contract.comments.blank?
  end

  def update
    if @contract.update(params_contract)  
      NotifyExpirationService.call(@contract)
      redirect_to users_backoffice_contracts_path, notice: "Atualização feita com sucesso!"
    else
      render :edit 
    end
  end

  def show
    @comments = @contract.comments
  end

  def destroy
    if @contract.destroy
      redirect_to users_backoffice_contracts_path, notice: "Remoção feita com sucesso!"
    else
      render :index
    end
  end

  private

    def set_contract
      @contract = Contract.find(params[:id])
    end

    def params_contract
      params_contract = params.require(:contract).permit(:persona_id, :price, :validation, :expiration, comments_attributes: [ :id, :user_id, :observation, :status])
    end
end
