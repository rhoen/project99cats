class CatRentalRequestsController < ApplicationController

  before_action :check_user_is_owner, only: [:approve, :deny]
  before_action :require_current_user, only: [:new, :create]

  def new
    @request = CatRentalRequest.new
    @request.cat_id = params[:cat_id]
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
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
