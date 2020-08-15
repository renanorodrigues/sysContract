module UsersBackofficeHelper
    def trans_attr(obj = nil, method = nil)
        if obj && method
            obj.human_attribute_name(method)
        else
            "Informar parâmetros"
        end
    end

    def final_state_contract(state)
        case state
        when 'E'
            'Exame'
        when 'A'
            'Aprovado'
        when 'R'
            'Reprovado'
        else
            'Caractere inválido!'
        end
    end
        
end
