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

  def process_zip(upload_params)
    parsed_results = []

    #TODO get rid of additional zip_file
    #TODO put parsed_results to result
    Zip::File.open("#{TMP_FOLDER}/#{upload_params[:source]}") do |zip_file|

      #TODO open to the same folder, rewrite
      zip_file.each { |f|
        f_path=File.join(Rails.root, 'tmp1', f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
        process_files_inside_zip(f_path, parsed_results)
      }
    end

    #TODO check if data is wrong and files don't match with each other
    persist_result(DataAnalizer.new.match_data(parsed_results))
  end

  private

  def process_files_inside_zip(f_path, parsed_results)
    #TODO check Parser parent class
    Dir.glob("#{f_path}/*") do |file|
      extention = File.extname(file).strip.downcase[1..-1]
      if extention == 'json'
        parsed_results << Json_Parser.parse_json(file)&.reject(&:empty?)
      elsif extention == 'csv'
        parsed_results << Csv_Parser.parse_csv(file)&.reject(&:empty?)
      end
    end
  end

  def persist_result(result_array)
    result_array.map{|route| Route.create(route) if route[:route_id]}
  end
end