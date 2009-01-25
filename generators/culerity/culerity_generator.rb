class CulerityGenerator < Rails::Generator::Base
  
  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir('features/step_definitions') unless File.directory?('features/step_definitions')
    super
  end

  def manifest
    record do |m|
      m.template  'common_celerity.rb', 'features/step_definitions/common_celerity.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} culerity"
  end

end
