class UsersBackoffice::PersonasController < UsersBackofficeController
  before_action :set_persona, only: [:edit, :update, :destroy]
  before_action :identify_person, only: [:show]

  def index
    @personas = Persona.all
    respond_to do |format|
      format.json {@persona = Persona.search(params[:term])}
      format.html
      format.pdf
      format.xlsx do 
        filename = GenerateXLSXService.call(@personas)
        send_data(File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename)
      end
    end
  end

  def new
    @persona = Persona.new
  end

  def create
    @persona = Persona.new(params_persona)
    if @persona.save
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
    if @persona.update(params_persona)
      AdminMailerService.call(current_persona, @persona)
      redirect_to users_backoffice_personas_path, notice: "Atualização feita com sucesso!"
    else
      render :edit 
    end
  end

  def destroy
    if @persona.destroy
      redirect_to users_backoffice_personas_path, notice: "Remoção feita com sucesso!"
    else
      render :index
    end
  end

  private

  def identify_person
    if !params[:identification].blank?
      value = params[:identification]
      @personas = Persona.where(identification: value)
    end
  end
  
  def set_persona
    @persona = Persona.find(params[:id])
  end

  def params_persona
    params_persona = params.require(:persona).permit(:email, :full_name, :identification, :observation)
  end
end
