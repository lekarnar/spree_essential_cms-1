class Spree::Admin::PageImagesController < Spree::Admin::ResourceController

  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  def update_positions
    params[:positions].each do |id, index|
      Spree::PageImage.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end

  private

  def location_after_save
    admin_page_images_url(@page.path)
  end

  def load_data
    id = params[:page_id]
    if params[:page_id] == "_home_"
      id = "/"
    elsif params[:page_id][0] != "/"
      id = "/" + params[:page_id]
    end
    @page = Spree::Page.find_by_path(id)
  end

  def set_viewable
    @page_image.viewable = @page
  end

  def destroy_before
    @viewable = @page_image.viewable
  end

end
