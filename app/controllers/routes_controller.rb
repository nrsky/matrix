require 'rubygems'
require 'zip'
require 'open-uri'
require 'csv'

class RoutesController < ApplicationController
  def download
    begin
      file_helper = FileHelper.new
      file_helper.download_zip(download_params)
      result  = file_helper.process_zip(download_params)

      render json: {count: result.count}, status: :ok
    rescue Exception => e
      render json: { :errors => [e.message] }, status: 422
    end
  end

  def upload
    begin
      render json: Route.with_source(upload_params[:source]), status: :ok
    rescue Exception => e
      render json: { :errors => [e.message] }, status: 422
    end
  end
end

private

def download_params
  [:source, :passphrase].each_with_object(params) do |key, obj|
    obj.require(key)
  end
end

def upload_params
  [:source, :passphrase].each_with_object(params) do |key, obj|
    obj.require(key)
  end
end
