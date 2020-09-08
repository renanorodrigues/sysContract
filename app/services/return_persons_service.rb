class ReturnPersonsService < ApplicationService 

    def initialize(identification)
        @identification = identification
    end

    def call
       return_persons 
    end

    def return_persons
    end

end 