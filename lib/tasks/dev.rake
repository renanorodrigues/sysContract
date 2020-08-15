namespace :dev do
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configuração do ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      %x(
        rails dev:purge_all_contracts
        rails db:drop
        rails db:create
        rails active_storage:install
        rails db:migrate
        rails dev:add_default_users
        rails dev:add_default_enterprises
        )
    else
      puts "Você não está no ambiente de desenvolvimento!"
    end
  end

  desc "Configuração do ambiente de desenvolvimento"
    task env_production: :environment do
      if Rails.env.production?
        %x(
          rails active_storage:install
          rails db:migrate
          rails dev:add_default_profiles
          rails dev:add_default_users
          )
      else
        puts "Você não está no ambiente de desenvolvimento!"
      end
    end

  desc "Removendo todos os arquivos do Active Storage"
  task purge_all_contracts: :environment do
    ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
  end

  desc "Adicionando usuários padrões"
  task add_default_users: :environment do
    User.create!(
      email: 'admin@email.com',
      password: '123456',
      first_name: Faker::Name.first_name,
      last_name: "#{Faker::Name.middle_name} #{Faker::Name.last_name}",
      profile: "Administrador"
    )

    User.create!(
      email: 'aprovador@email.com',
      password: '654123',
      first_name: Faker::Name.first_name,
      last_name: "#{Faker::Name.middle_name} #{Faker::Name.last_name}",
      profile: "Aprovador"
    )

    User.create!(
      email: 'analista@email.com',
      password: '654789',
      first_name: Faker::Name.first_name,
      last_name: "#{Faker::Name.middle_name} #{Faker::Name.last_name}",
      profile: "Analista"
    )

    User.create!(
      email: 'auxiliar@email.com',
      password: '987456',
      first_name: Faker::Name.first_name,
      last_name: "#{Faker::Name.middle_name} #{Faker::Name.last_name}",
      profile: "Auxiliar"
    )

    User.create!(
      email: 'advogado@email.com',
      password: '0654789',
      first_name: Faker::Name.first_name,
      last_name: "#{Faker::Name.middle_name} #{Faker::Name.last_name}",
      profile: "Advogado"
    )
  end

  desc "Adicionando empresas de teste"
    task add_default_enterprises: :environment do
      5.times do
        Persona.create!(
          full_name: Faker::Company.name,
          email: Faker::Internet.email,
          observation: Faker::Lorem.paragraph(sentence_count: 2),
          identification: 'Cliente'
        )
      end
    end
end
