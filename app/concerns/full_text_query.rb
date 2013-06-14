module FullTextQuery
  def query_helper name, value, query_string, query_array
    if !value.nil? then
      if !value.empty? then
        query_string += " OR " unless query_string.empty?
        query_string += "#{name} LIKE ?"
        query_array.push("%#{value}%")
      end
    end
    query_string
  end

  def like_query on, kv
    query = ""
    query_array = []
    kv.keys.sort.each do |key|
      query = query_helper key, kv[key], query, query_array
    end
	
    on.where(query, *query_array)
  end
end
