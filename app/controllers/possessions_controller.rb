class PossessionsController < ApplicationController
  before_action :set_possession, only: %i[edit update destroy]

  def index
    @possessions = current_user.possessions.order(:possession_type, :name)
    @by_type = @possessions.group_by(&:possession_type)
    @total_purchase_value = @possessions.sum(:purchase_price) || 0
    @total_current_value = @possessions.sum(:current_value) || 0
    @net_change = @total_current_value - @total_purchase_value
  end

  def new
    @possession = current_user.possessions.build(
      possession_type: "other",
      color: "#6C63FF",
      currency: "BRL"
    )
  end

  def create
    @possession = current_user.possessions.build(possession_params)

    if @possession.save
      redirect_to possessions_path, notice: t("controllers.possessions.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @possession.update(possession_params)
      redirect_to possessions_path, notice: t("controllers.possessions.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @possession.destroy
    redirect_to possessions_path, notice: t("controllers.possessions.destroyed")
  end

  private

  def set_possession
    @possession = current_user.possessions.find(params[:id])
  end

  def possession_params
    params.require(:possession).permit(:name, :possession_type, :purchase_price, :current_value, :purchase_date, :currency, :color, :notes)
  end
end
