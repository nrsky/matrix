require 'rubygems'
require 'zip'
require 'open-uri'
require 'csv'

class RoutesController < ApplicationController
  def index
    begin
      file_helper = FileHelper.new
      file_helper.download_zip(upload_params)
      result  = file_helper.process_zip(upload_params)
      render json: result, status: :created
    rescue Exception => e
      render json: { :errors => [e.message] }, status: 422
    end
  end
end

private

def upload_params
  params.permit(:source, :passphrase)
end
