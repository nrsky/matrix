#NOTE class works with the array of hashes(each hash represents the data from uploaded file)
class DataAnalizer
  #NOTE loops via array of hashes, where each hash represents data loaded from a file,
  # cheks, if there are same keys in the hashes('fields') and merges hashes if so.
  # loops until there are only hashes without matching values left
  # deletes element of array, which was merged.
  # in the perfect case when there is matching data in all files only 1 element of array will remain.
  def join_data(data)
    if data.present?
      while(can_be_merged?(data)) do
        join_hashes(data)
      end
      data.count == 1 ?  data[0] : data
    end
  end

  private

  #NOTE checks if the hash data, which was uploaded from one file
  # has the same key(field name) as data from another, so we can join two hashes on this field,
  # loops via all files and compare each 2
  def can_be_merged?(array)
    array.combination(2).any? { |a, b|
      a[0].keys.select { |a_header| b[0].keys.include?(a_header) }.first if a.present? && b.present?
    }
  end

  def join_hashes(array)
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