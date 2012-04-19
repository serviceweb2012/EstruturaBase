class Permission < ActiveRecord::Base
  belongs_to :role
  validates_presence_of :role_id, :model_name
  validates_uniqueness_of :model_name, :scope => [:role_id]
  validates_length_of :model_name, :within => 3..100
  scope :actived?, :conditions => { :situation => true }

  def actions_model=(actions_model)
    self.actions = actions_model.join(";").chomp unless actions_model.nil?
  end

  def action_include?(action)
    return true if self.actions =~ /(#{Regexp.escape(action)})/mi
    false
  end

  protected
  def self.list_models
    arqs = []
    dir_model = "#{Rails.root.to_s}/app/models"
    Dir.foreach(dir_model) {|f| arqs << f }
    arqs.reject! { |f| (f == "." || f == "..") }
    models = []
    arqs.each do |a|
      next if a =~ /mailer/
      next if a =~ /observer/
      model_name = a.gsub!(/(.rb\b)/, "")
      path = "#{Rails.root.to_s}/app/controllers/admin/#{model_name.pluralize}_controller.rb"
      inc_model = File.exist?(path)
      model_name = a.camelize
      models << model_name if inc_model
    end
    models << "Home"
    models
  end

  def self.list_actions_by_model(model)
    actions = []
    if !model.nil? && !model.blank?
      controller_name = model.underscore.pluralize
      path = "#{Rails.root.to_s}/app/controllers/admin/#{controller_name}_controller.rb"

      env = /(def .*$)/
      File.open(path) do |f|
        f.each_line do |line|
          next if line =~ /def find/
          break if line =~ /protected/
          break if line =~ /private/
          if line =~ env
            actions << line.gsub(/(def )/, "").chomp.lstrip
          end
        end
      end
    end
    actions
  end
end

