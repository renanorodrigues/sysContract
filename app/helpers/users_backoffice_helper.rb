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
    
    def decision_comment(user, comment_decision)
        if user.profile == "Analista" || user.profile == "Advogado"
            comment_decision ? 'Contrato anuído' : 'Contrato dispensado'
        else
            comment_decision ? 'Contrato aprovado' : 'Contrato reprovado'
        end
    end

    def duration_contract(validation, expiration)
        date = ((expiration - validation) / (24 * 60 * 60)).to_i
        return date
    end
end
