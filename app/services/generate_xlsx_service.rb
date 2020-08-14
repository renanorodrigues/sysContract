class GenerateXLSXService < ApplicationService

    def initialize(obj)
        @obj = obj
    end

    def call
        generate_xlsx
    end

    def generate_xlsx
        name_obj = @obj.model_name.to_s.downcase

        filename = "#{name_obj}_#{Time.now.strftime("%Y%m%d%S")}.xlsx"
        workbook = WriteXLSX.new("/tmp/#{filename}")
        worksheet = workbook.add_worksheet
        worksheet.paper = 9    # A4
        
        format = workbook.add_format
        format.set_bold
        format.set_align('center')
        format.set_text_wrap()

        if name_obj == 'user'
            worksheet.write(0, 0, "ID", format)
            worksheet.write(0, 1, "Nome", format)
            worksheet.write(0, 2, "Sobrenome", format)
            worksheet.write(0, 3, "Email", format)
            worksheet.write(0, 4, "Perfil", format)
            worksheet.write(0, 5, "Data de registro", format)

            i = 1
            @obj.each do |u|
                worksheet.write(i, 0, u.id)
                worksheet.write(i, 1, u.first_name)
                worksheet.write(i, 2, u.last_name)
                worksheet.write(i, 3, u.email)
                worksheet.write(i, 4, u.profile.description)
                worksheet.write(i, 5, I18n.l(u.created_at, format: :short))
            i += 1
            end
        end

        if name_obj == 'contract'
            worksheet.write(0, 0, "ID", format)
            worksheet.write(0, 1, "Título", format)
            worksheet.write(0, 2, "Descrição", format)
            worksheet.write(0, 3, "Comentários", format)
            worksheet.write(0, 4, "Deliberação", format)
            worksheet.write(0, 5, "Data de registro", format)

            i = 1
            @obj.each do |u|
                worksheet.write(i, 0, u.id)
                worksheet.write(i, 1, u.title)
                worksheet.write(i, 2, u.description)
                worksheet.write(i, 3, u.comments.count)
                worksheet.write(i, 4, u.final_status)
                worksheet.write(i, 5, I18n.l(u.created_at, format: :short))
            i += 1
            end
        end

        workbook.close

        return filename
    end
end