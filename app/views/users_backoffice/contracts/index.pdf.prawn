prawn_document do |pdf|
  pdf.text 'Relatório de contratos'
  pdf.move_down 30
  pdf.table [['ID', 'Título', 'Descrição','Deliberação','Data de registro']] +
  @contracts.collect{ |c| [c.id, c.title, c.description, c.final_status, c.created_at.to_s]}
end