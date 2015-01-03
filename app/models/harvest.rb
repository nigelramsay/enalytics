class Harvest
  def initialize(station_id:)
    @station_id = station_id.to_i
  end

  def recorded_at
    title && DateTime.strptime(title, 'Weather at %H:%M %a %e %b %Y')
  end

  def temperature
    BigDecimal(temperature_content[0..-3], 1)
  end

  def wind_speed
    wind_speed_content.match(/[\d\.]+/).to_s
  end

  def wind_direction
    wind_speed_content.match(/Wind\s([NESW]+)\s.*/)[1]
  end

  def wind_gust
    wind_gust_content.match(/Gust\s([\d\.]+)km\/h/)[1]
  end

  private

  def title
    document.css('#title').first.content.strip
  end

  def temperature_content
    document.css('#temp').first.content.strip
  end

  def wind_speed_content
    document.css('#windspd').first.content.strip
  end

  def wind_gust_content
    document.css('#windgust').first.content.strip
  end

  def document
    Nokogiri::HTML(query)
  end

  def host
    'harvestelectronics.com'
  end

  def query_string
    "/w.cgi?hsn=#{@station_id}&cmd=cwc"
  end

  def query
    @query ||= begin
      http = Net::HTTP.new(host)
      response = http.request(Net::HTTP::Get.new(query_string))

      if response.code != "200"
        $stderr.puts "Harvest error (status-code: #{response.code})\n#{response.body}"

        nil
      else
        response.body
      end
    end
  end
end