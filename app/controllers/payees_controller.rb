class PayeesController < ApplicationController
  before_action :set_payee, only: %i[edit update destroy]

  def index
    @payees = current_user.payees.order(:name)

    respond_to do |format|
      format.html
      format.json do
        q = params[:q].to_s.strip
        results = current_user.payees
          .where("name ILIKE ?", "%#{q}%")
          .order(:name)
          .limit(10)
          .pluck(:id, :name)
          .map { |id, name| { id: id, name: name } }
        render json: results
      end
    end
  end

  def new
    @payee = current_user.payees.build
  end

  def create
    @payee = current_user.payees.build(payee_params)

    if @payee.save
      redirect_to payees_path, notice: t("controllers.payees.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @payee.update(payee_params)
      redirect_to payees_path, notice: t("controllers.payees.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payee.destroy
    redirect_to payees_path, notice: t("controllers.payees.destroyed")
  end

  private

  def set_payee
    @payee = current_user.payees.find(params[:id])
  end

  def payee_params
    params.require(:payee).permit(:name)
  end
end
