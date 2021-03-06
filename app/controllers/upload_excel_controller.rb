class UploadExcelController < ApplicationController

def index
end

#to get data from csv file 
def get_data 
	# import method written in model 
	import_user = User.import(params[:user][:file])
	if import_user 
	flash[:notice] = "Users uploaded successfully"
	redirect_to excel_show_path
	else
		flash[:notice] = "Somthing Wrong"
		redirect_to excel_show_path
	end
	
end

#show the data from database 
def show 
	@data = User.all
end

 #To delete entry from database 
def delete_data	
	delete_data = params[:delete_users][:data].split(" ")
	User.where(id: delete_data).destroy_all
	redirect_to excel_show_path
end

# # to download data as csv file 
def download 
	@user = User.all
	respond_to do |format|
		format.html
		format.csv { send_data @user.to_csv }
	end
end

end
