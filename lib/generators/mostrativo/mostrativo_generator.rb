class MostrativoGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_configs
    copy_file 'config.rb', 'config/initializers/config.rb'
    copy_file 'pt-BR.yml', 'config/locales/pt-BR.yml'
    copy_file 'devise.pt-BR.yml','config/locales/devise.pt-BR.yml'
    copy_file 'devise.en.yml','config/locales/devise.en.yml'
    copy_file 'routes.txt', 'config/routes.rb'
    copy_file 'devise.rb','config/initializers/devise.rb'
    copy_file 'boot.rb','config/boot.rb'
    copy_file 'Gemfile',"#{Rails.root.to_s}/Gemfile"
  end

  def create_mvc
    # copia o que está na pasta templates/app para a pasta app do projeto.
    origem  = File.join(File.dirname(__FILE__),"templates","app")
    destino = Rails.root.to_s
    FileUtils.cp_r origem,destino
  end

  def create_public
    # copia o que está na pasta templates/public para a pasta app do projeto.
    origem  = File.join(File.dirname(__FILE__),"templates","public")
    destino = Rails.root.to_s
    FileUtils.cp_r origem,destino
  end

  def create_migrations
      Dir.chdir(File.join(Rails.root.to_s,'db'))
      Dir.mkdir('migrate') unless Dir.exist?('migrate')
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_dashboards.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now).strftime("%Y%m%d%H%M%S")}_create_dashboards.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_four_oh_fours.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 1.seconds).strftime("%Y%m%d%H%M%S")}_create_four_oh_fours.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_locations.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 2.seconds).strftime("%Y%m%d%H%M%S")}_create_locations.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_menus.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 3.seconds).strftime("%Y%m%d%H%M%S")}_create_menus.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_owners.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 4.seconds).strftime("%Y%m%d%H%M%S")}_create_owners.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_permissions.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 5.seconds).strftime("%Y%m%d%H%M%S")}_create_permissions.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_roles.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 6.seconds).strftime("%Y%m%d%H%M%S")}_create_roles.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/create_sub_menus.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 7.seconds).strftime("%Y%m%d%H%M%S")}_create_sub_menus.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/devise_create_users.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 8.seconds).strftime("%Y%m%d%H%M%S")}_devise_create_users.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/gerar_menus_admin.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 9.seconds).strftime("%Y%m%d%H%M%S")}_gerar_menus_admin.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/join_menus_roles.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 10.seconds).strftime("%Y%m%d%H%M%S")}_join_menus_roles.rb"
      copy_file "#{Rails.root.to_s}/lib/generators/mostrativo/templates/db/migrate/join_sub_menus_roles.rb", "#{Rails.root.to_s}/db/migrate/#{(Time.now + 11.seconds).strftime("%Y%m%d%H%M%S")}_join_sub_menus_roles.rb"
  end

  def delete_index_html
    Dir.chdir("#{Rails.root.to_s}/public")
    FileUtils.rm 'index.html' if  File.exist?('index.html')
  end

end

