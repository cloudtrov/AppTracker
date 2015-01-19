class AppsController < ApplicationController
	
	def index
		@apps = App.all  
	end

	def new
		@app = App.new
		@app.deploy = Deploy.new()
	end

	def create 
		@app = App.new(params.require(:app).permit(:file_name, :date_created, :location, :description, :reference))
		@app.deploy = Deploy.new(params.require(:app).require(:deploy_attributes).permit(:platform_used, :deployment_date, :deployed_name))

		if @app.save
			redirect_to apps_path
		else
			render :new
		end
	end

	def show 
		@app = App.find(params[:id])
	end

	def edit 
		@app = App.find(params[:id])
	end

	def update
		@app = App.find(params[:id])
		if @app.update_attributes(params.require(:app).permit(:file_name, :date_created, :location, :description, :reference)) && @app.deploy.update_attributes(params.require(:app).require(:deploy_attributes).permit(:platform_used, :deployment_date, :deployed_name))
			redirect_to apps_path
		else
			render "edit"
		end
	end



end