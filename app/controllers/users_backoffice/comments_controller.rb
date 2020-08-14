class UsersBackoffice::CommentsController < UsersBackofficeController
  before_action :set_comment, only: [:edit, :update]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(params_comment)
    if comment.save
      @contract = comment.contract
      ApproveContractService.call(@contract)
      redirect_to users_backoffice_contract_path(@contract), notice: "Comentário cadastrado!"
    else
      render:new
    end
  end

  def edit
  end

  def update
    if @comment.update(params_comment)
      @contract = @comment.contract
      ApproveContractService.call(@contract)
      redirect_to users_backoffice_contract_path(@contract), notice: "Atualização feita com sucesso!"
    else
      render :edit 
    end
  end
  
  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def params_comment
      params_comment = params.require(:comment).permit(:user_id, :contract_id, :observation, :status)
    end
end
