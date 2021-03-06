class User < ApplicationRecord
  validates_presence_of :email
    require 'roo'
	# To import data using csv file and saving in database 
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

    # def self.attr_names
    #   %w(email first_name last_name)
    # end
# 
    def self.import(file)
      @errors = []
      data = open_spreadsheet(file)
       # open spreadsheet
      data.sheets.each do |num|
        data.sheet(num)
        headers = data.row(1) # get header row
        data.each_with_index do |row, idx|
          next if idx == 0 # skip header row
          # create hash from headers and cells
          user_data = Hash[[headers, row].transpose]
          # next if user exists
          if User.exists?(email: user_data['email'])
            puts "User with email #{user_data['email']} already exists"
            next
          end
          # user_data.inspect
          # student = find_by_id(user_data["id"]) || new
          user = User.new(user_data)
          # user.attributes = user_data.to_hash.slice(*attr_names)
          puts "Saving User with email '#{user.email}'"
          if user.save
          else
            user.errors.full_messages.each do |message|
              @errors << "Issue line #{idx}, column #{message}"
            end
          end
        end
      end
      @errors
    end

end

