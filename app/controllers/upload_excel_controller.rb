class UploadExcelController < ApplicationController

def index
end

#to get data from csv file 
def get_data 
	# import method written in model 
	import_user = User.import(params[:user][:file])
	if import_user == []
		flash[:notice] = "Users uploaded successfully"
		redirect_to excel_show_path
	else
		sheet = []
		validation = []
		total_row = []
		sheet << import_user[0].split(",")[1]
		total_row << import_user[0].split(",")[2]
		import_user.each do |data|
			validation << data.split(",")[0].split("-")[0] + "-" + data.split(",")[0].split("-")[1]
		end
		flash[:notice] = "#{sheet} , #{validation}, #{total_row}"
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

end
