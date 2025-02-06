class HomeController < ApplicationController

  ELEMENTS_PER_PAGE = 10

  skip_before_action :authenticate_user!, only: [:login]
  before_action :find_billboard, only: [:upvote, :downvote]

  def login
    render "layouts/login"
  end

  def index
    @per_page = ELEMENTS_PER_PAGE
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_billboards = Billboard.count

    case params[:filter]
    when "trending"
      @billboards = Billboard.top.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    when "fresh"
      @billboards = Billboard.fresh.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    else
      @billboards = Billboard.recent.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    end

    respond_to do |format|
      format.html
      format.json do 
        render json: { 
          html: render_to_string(
            partial: "home/list", 
            formats: [:html], 
            locals: { billboards: @billboards, page: @page }
          ) 
        }
      end
    end
  end

  def show_batch_import; end

  def batch_import
    @csv_upload = CsvUpload.new(
      title: csv_upload_params[:title],
      file: csv_upload_params[:file],
    )
    if @csv_upload.save
      ProcessCsvJob.perform_later(@csv_upload.id)
      redirect_to home_index_path, notice: "CSV file uploaded successfully! Processing in the background."
    else
      render :new
    end
  end

  def upvote
    @billboard.increment(current_user)

    respond_to do |format|
      format.json { render json: { likes: @billboard.likes, dislikes: @billboard.dislikes } }
    end
  end

  def downvote
    @billboard.decrement(current_user)
    
    respond_to do |format|
      format.json { render json: { likes: @billboard.likes, dislikes: @billboard.dislikes } }
    end
  end
  
  private
  
  def find_billboard
    @billboard = Billboard.find(params[:id])
  end

  def csv_upload_params
    params.require(:csv_upload).permit(:title, :file)
  end
end
