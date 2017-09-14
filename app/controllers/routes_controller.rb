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

    result_array = []

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

      if result_array.present?
        while(can_be_merged?(result_array)) do
         get_keys(result_array)
        end
      end
      result_array
    end
  end
end

private

def upload_params
  params.permit(:source, :passphrase)
end

def can_be_merged?(array)
  array.combination(2).any? { |a, b|
    a[0].keys.select { |a_header| b[0].keys.include?(a_header) }.first if a.present? && b.present?
  }
end

def get_keys(array)
  array.combination(2).any? { |a, b|
    headers_a =   a[0].keys
    headers_b = b[0].keys

    key = headers_a.select { |a_header| headers_b.include?(a_header) }.first if a.present? && b.present?
    if key.present?
      merge_hashes(array, a, b, key)
    end
  }
end

def merge_hashes(array, a, b, key)
  a.each do |al|
    b.each do |bl|
      if al[key] == bl[key]
        al.merge!(bl)
      end
    end
  end
  array.delete(b)
end