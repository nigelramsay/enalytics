class HeatMiser
  def initialize(ip_address: nil)
    @ip_address = ip_address || '192.168.1.7'
  end

  def current_temperature
    stats[:current_temperature]
  end

  def set_temperature
    stats[:set_temperature]
  end

  def heating?
    stats[:heating]
  end

  def stats
    @_stats ||= begin
      result = {}

      if response = query('/right.htm')
        response.split('\n').each do |line|
          if line.match(/<b>Actual.*font size='5'>(\d{1,2}\.\d)/)
            result[:current_temperature] = $1;
          end

          if line.match(/<b>Heat Status.*font size='4'>(O[NF]{1,2})/)
            result[:heating] = ($1 == 'ON') ? 1 : 0;
          end

          if line.match(/<b>Set.*font size='4'>(\d{1,2})/)
            result[:set_temperature] = $1;
          end
        end
      end

      result
    end
  end

  def query(query_string)
    http = Net::HTTP.new(@ip_address)
    response = http.request(Net::HTTP::Get.new(query_string))

    if response.code != "200"
      $stderr.puts "HeatMiser error (status-code: #{response.code})\n#{response.body}"

      nil
    else
      response.body
    end
  end
end