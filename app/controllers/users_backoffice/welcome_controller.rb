class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @comments = Comment.order(:created_at).last(3).reverse
    @tot_info = []
    @tot_info[0] = User.all.count
    @tot_info[1] = Persona.all.count
    @tot_info[2] = Document.all.count
    @tot_info[3] = Contract.all.count
    @tot_info[4] = Comment.all.count
    @tot_info[5] = Contract.where(status: 'A').count
  end
end
