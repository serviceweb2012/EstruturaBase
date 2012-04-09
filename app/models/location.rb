class Location < ActiveRecord::Base
  has_attached_file :image,
                     :styles => { :small => "250x250!" },
                     :default_style => :small,
                     :url => "/images/locations/:style/:basename.:extension",
                     :path => ":rails_root/public/images/locations/:style/:basename.:extension"
                     #, :default_url => "/images/sem_imagem.png"

   #validates_attachment_presence :image, :message => "deve ser setada"
   validates_attachment_size :image, :less_than => 150.kilobytes, :message => "deve ser menor que 150 kb"
   validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/gif'], :message => "deve estar no formato (JPG, PNG ou GIF)"

   validates_presence_of :name,:number
   validates_numericality_of :number
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	def formated_phone
    "(#{self.phone[0..1]}) #{self.phone[2..5]}.#{self.phone[6..9]}" unless self.phone.blank?
  end

  def formated_cep
    "#{self.cep[0..4]} - #{self.cep[5..7]}" unless self.cep.blank?
  end

  def delete_image(caminho,arquivo)
		Dir.foreach(caminho) do |nome_diretorio|
			if File.exist?("#{caminho}/#{nome_diretorio}/#{arquivo}")
				File.delete("#{caminho}/#{nome_diretorio}/#{arquivo}")
			end
		end
   end

end

