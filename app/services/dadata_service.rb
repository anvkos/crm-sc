require 'faraday'

class DadataService
  KINDS = {
    "LEGAL" => 'ЮЛ',
    'INDIVIDUAL' => 'ИП'
  }.freeze

  attr_reader :base_url

  def initialize(options = {})
    @base_url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs'
    @token = options[:token] || Rails.application.credentials.dig(:dadata_api_key)
  end

  def suggest(query)
    data = request(url: '/suggest/party', query: query)
    prepare_suggestions(data)
  end

  private

  attr_reader :token

  def prepare_suggestions(data)
    return [] unless data.key?("suggestions")

    data["suggestions"].map do |value|
      item = value["data"]
      OpenStruct.new(
        name: item["name"]["short_with_opf"],
        inn: item["inn"],
        ogrn: item["ogrn"],
        kind: kind(item["type"])
      )
    end
  end

  def kind(name)
    KINDS[name]
  end

  def request(params)
    conn = Faraday.new(
      url: "#{base_url}#{params[:url]}",
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Token #{token}"
      }
    ) do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.post do |req|
      req.body = { query: params[:query] }.to_json
    end
    JSON.parse(response.body)
  rescue Faraday::Error, JSON::ParserError
    nil
  end
end
