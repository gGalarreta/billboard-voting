class HomeController < ApplicationController

  ELEMENTS_PER_PAGE = 10

  def index
    @per_page = ELEMENTS_PER_PAGE
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_billboards = Billboard.count
    @billboards = Billboard.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)

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
      format.js
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
      redirect_to root_path, notice: "CSV file uploaded successfully! Processing in the background."
    else
      render :new
    end
  end

  private

  def csv_upload_params
    params.require(:csv_upload).permit(:title, :file)
  end
end
