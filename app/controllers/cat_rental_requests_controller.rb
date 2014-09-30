class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    @request.cat_id = params[:cat_id]
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:request_id])
    @request.approve!
    redirect_to cat_url(params[:id])
  end

  def deny
    @request = CatRentalRequest.find(params[:request_id])
    @request.deny!
    redirect_to cat_url(params[:id])
  end

  private
  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date)
  end
end
