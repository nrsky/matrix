class DataAnalizer
  def match_data(data)
    if data.present?
      while(can_be_merged?(data)) do
        get_keys(data)
      end
    end
    data.count == 1 ?  data[0] : data
  end

  private

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
end