require 'rubygems'
require 'zip'
require 'open-uri'
require 'csv'

class RoutesController < ApplicationController

  def index
    return unless upload_params

    source = upload_params[:source]
    passphrase = upload_params[:passphrase]
    domain = 'challenge.distribusion.com'
    url = "https://#{domain}/the_one/routes?passphrase=#{passphrase}&source=#{source}"

    open(File.join(Rails.root, 'tmp', source), 'wb') do |file|
      file << open(url).read
    end

    Zip::File.open(File.join(Rails.root, 'tmp', source)) do |zip_file|
      zip_file.each { |f|
        f_path=File.join(Rails.root, 'tmp1', f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)

        Dir.glob("#{f_path}/*") do |file|
          extention = File.extname(file).strip.downcase[1..-1]
          if extention == 'json'
            Json_Parser.parse_json(file)
          elsif extention == 'csv'
            Csv_Parser.parse_csv(file)
          end
        end
      }
    end
  end
end

private

def upload_params
  params.permit(:source, :passphrase)
end

