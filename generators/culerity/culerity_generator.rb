class CulerityGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.directory 'features/step_definitions'
      m.template  'common_celerity_steps.rb', 'features/step_definitions/common_celerity_steps.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} culerity"
  end

end
