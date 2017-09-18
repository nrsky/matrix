require 'zip/zip'
class FileHelper
  TMP_FOLDER = File.join(Rails.root, 'tmp')

  #TODO refactor upload params
  def download_zip(upload_params)
    source     = upload_params[:source]
    passphrase = upload_params[:passphrase]
    domain     = 'challenge.distribusion.com'
    url        = "https://#{domain}/the_one/routes?passphrase=#{passphrase}&source=#{source}"

    open("#{TMP_FOLDER}/#{source}", 'wb') do |file|
      file << open(url).read
    end
  end

  #TODO check if data is wrong and files don't match with each other, raise custom exceptions
  def process_zip(upload_params)
    path = "#{TMP_FOLDER}/#{upload_params[:source]}"
    destination = "#{TMP_FOLDER}/fixtures"

    unzip_file(path, destination)
    parsed_results = process_files_inside_zip("#{destination}/#{upload_params[:source]}")
    persist_result(DataAnalizer.new.join_data(parsed_results)&.reject(&:nil?))
  end

  private

  def unzip_file(file, destination)
    if File.exist?(destination) then
      FileUtils.rm_rf destination
    end
    Zip::ZipFile.open(file) { |zip_file|
      zip_file.each { |f|
        f_path=File.join(destination, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path)
      }
    }
  end

  def process_files_inside_zip(f_path)
    parsed_results = []

    Dir.glob("#{f_path}/*") do |file|
      extention = File.extname(file).strip.downcase[1..-1]
      if extention == 'json'
        parsed_results << Json_Parser.parse_json(file)&.reject(&:empty?)
      elsif extention == 'csv'
        parsed_results << Csv_Parser.parse_csv(file)&.reject(&:empty?)
      end
    end

    parsed_results
  end

  def persist_result(result_array)
    result_array.map{|route| Route.create(route) if route[:route_id]}
  end
end