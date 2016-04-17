module TwilioHelper
  def self.parse_body(params)
    result = {}
    params['Body'].split(',').map do |kv|
      pair = kv.split(':').map(&:strip)
      if pair.length == 2
        result[pair[0]] = pair[1]
      else
        next
      end
    end
    return result
  end
end