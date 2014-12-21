class Spree::PageImage < Spree::Asset
  
  has_attached_file :attachment,
    :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium,
    :path => '/spree/pages/:attachment/:id/:style/:basename.:extension',
    :url => ':path'
    
  validates_attachment_presence :attachment
  
  validates_attachment :attachment,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def image_content?
    attachment_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def attachment_sizes
    sizes = {}
    if image_content?
      sizes.merge!(:mini => '48x48>', :small => '150x150>', :medium => '800x800#', :large => '1000x1000#')
      sizes.merge!(:slide => '1500x') if viewable.respond_to?(:root?) && viewable.root?
    end
    sizes
  end

end
