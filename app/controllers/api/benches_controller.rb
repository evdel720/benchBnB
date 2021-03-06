class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.in_bounds(params[:bounds])
    @benches = @benches.where("seats > ?", params[:minSeating]) if params[:minSeating] && params[:minSeating] != ""
    @benches = @benches.where("seats < ?", params[:maxSeating]) if params[:maxSeating] && params[:maxSeating] != ""
    render :index
  end

  def show
    @bench = Bench.find_by(id: params[:id])
    if @bench
      render :show
    else
      @errors = ["It doesn't exists"]
      render './errors'
    end
  end

  def create
    @bench = Bench.new(bench_params)
    if @bench.save
      render :show
    else
      @errors = @bench.errors.full_messages
      render './errors'
    end
  end

  private

  def bench_params
    params.require(:bench).permit(:description, :lat, :lng, :seats)
  end
end
