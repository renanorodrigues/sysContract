prawn_document do |pdf|
  pdf.text 'Relatório de usuários'
  pdf.move_down 30
  pdf.table [['ID', 'Nome', 'Sobrenome', 'Email', 'Perfil','Data de registro']] + 
  @users.collect{ |u| [u.id, u.first_name, u.last_name, u.email, u.profile.description, u.created_at.to_s]}
end