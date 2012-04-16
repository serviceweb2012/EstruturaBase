class Owner < ActiveRecord::Base
  validates_presence_of :name,:representative,:cnpj,:phone

  has_attached_file :image,
                     :styles => { :small => "160x160!" },
                     :default_style => :small,
                     :url => "/images/owners/:style/:basename.:extension",
                     :path => ":rails_root/public/images/owners/:style/:basename.:extension"
                     #, :default_url => "/images/sem_imagem.png"

   #validates_attachment_presence :image, :message => "deve ser setada"
   validates_attachment_size :image, :less_than => 150.kilobytes, :message => "deve ser menor que 150 kb"
   validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/gif'], :message => "deve estar no formato (JPG, PNG ou GIF)"


    def delete_image(caminho,arquivo)
		  Dir.foreach(caminho) do |nome_diretorio|
			  if File.exist?("#{caminho}/#{nome_diretorio}/#{arquivo}")
				  File.delete("#{caminho}/#{nome_diretorio}/#{arquivo}")
			  end
		  end
    end

end

