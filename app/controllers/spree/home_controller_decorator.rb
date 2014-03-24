Spree::HomeController.class_eval do
  
  before_filter :get_homepage
  
  def index
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    render :template => "spree/pages/home"      
  end
  
  private
  
    def get_homepage
      @page = Spree::Page.find_by_path("/")
    end
    
    def accurate_title
      @page.meta_title unless @page.nil?
    end
  
end
