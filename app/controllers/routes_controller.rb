require 'rubygems'
require 'zip'
require 'open-uri'
require 'csv'

class RoutesController < ApplicationController
  def index
    begin

      source     = upload_params[:source]
      passphrase = upload_params[:passphrase]
      domain     = 'challenge.distribusion.com'
      url        = "https://#{domain}/the_one/routes?passphrase=#{passphrase}&source=#{source}"

      open(File.join(Rails.root, 'tmp', source), 'wb') do |file|
        file << open(url).read
      end

      result_array = []
      result       = []

      Zip::File.open(File.join(Rails.root, 'tmp', source)) do |zip_file|
        zip_file.each { |f|
          f_path=File.join(Rails.root, 'tmp1', f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)

          Dir.glob("#{f_path}/*") do |file|
            extention = File.extname(file).strip.downcase[1..-1]
            if extention == 'json'
              result_array << Json_Parser.parse_json(file)&.reject(&:empty?)
            elsif extention == 'csv'
              result_array << Csv_Parser.parse_csv(file)&.reject(&:empty?)
            end
          end
        }

        result = DataAnalizer.new.get_data(result_array)
        if result.count == 1
          result = result[0]
        end

        end
      render json: result, status: :created
    rescue Exception => e
      print e.message
      render json: { :errors => [e.message] }, status: 422
    end
  end
end

private

def upload_params
  params.permit(:source, :passphrase)
end

