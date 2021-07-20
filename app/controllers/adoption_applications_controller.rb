class AdoptionApplicationsController < ApplicationController
  def new
  end

  def show
    @adopt_app = AdoptionApplication.find(params[:id])
    params[:search].present? ? (@pets = Pet.search(params[:search])) : (@pets = [])
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

  def update
    adopt_app = AdoptionApplication.find(params[:id])
    adopt_app.update(adopt_app_params)
    adopt_app.update(status: 'Pending') unless adopt_app[:description].nil?
    redirect_to "/adoption_applications/#{adopt_app.id}"
  end

  private

  def adopt_app_params
    params
      .permit(:name, :street_address, :city, :state, :zip_code, :status, :description)
  end
end
