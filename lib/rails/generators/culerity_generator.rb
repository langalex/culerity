class CulerityGenerator < ::Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  desc "Install Culerity into your application"
  def generate_culerity
    copy_file 'features/step_definitions/culerity_steps.rb', 'features/step_definitions/culerity_steps.rb'
    copy_file 'features/support/env.rb', 'features/support/culerity_env.rb'
    copy_file 'config/environments/culerity.rb', 'config/environments/culerity.rb'
    gsub_file 'config/environments/culerity.rb', /Rarp/, Rails::Application.subclasses[0].name.to_s.split("::")[0]
    gsub_file 'config/database.yml', /cucumber:.*\n/, "cucumber: &CUCUMBER\n"

    gsub_file 'config/database.yml', /\z/, "\nculerity:\n  <<: *CUCUMBER"
    
    copy_file "lib/tasks/culerity.rake", "lib/tasks/culerity.rake"
    
    copy_file 'public/javascripts/culerity.js', 'public/javascripts/culerity.js'
  end
end
