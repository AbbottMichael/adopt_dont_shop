class AdoptionApplicationsController < ApplicationController
  def new
  end

  def show
    @adopt_app = AdoptionApplication.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
  end

  def create
    adopt_app = AdoptionApplication.new(adopt_app_params)
    if adopt_app.save
      redirect_to "/adoption_applications/#{adopt_app.id}"
    else
      flash[:alert] = "Form not submitted!: #{error_message(adopt_app.errors)}"
      render :new
    end
  end

  private

  def adopt_app_params
    params
      .permit(:name, :street_address, :city, :state, :zip_code, :status)
      .with_defaults(status: 'In Progress')
  end
end
