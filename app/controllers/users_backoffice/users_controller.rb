class UsersBackoffice::UsersController < UsersBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.pdf
      format.xlsx do 
        filename = GenerateXLSXService.call(@users)
        send_data(File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      redirect_to users_backoffice_welcome_index_path, notice: "Usuário cadastrado!"
    else
      render:new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @user.update(params_user)
      AdminMailerService.call(current_user, @user)
      redirect_to users_backoffice_users_path, notice: "Atualização feita com sucesso!"
    else
      render :edit 
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_backoffice_users_path, notice: "Remoção feita com sucesso!"
    else
      render :index
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def params_user
    params_user = params.require(:user).permit(:email, :password, :first_name, :last_name, :cpf, :profile_id)
  end

  def verify_password
    if params[:user][:password].blank?
      params[:user].extract!(:password)
    end
  end
end
