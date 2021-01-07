require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def check_unsafe_image_data(image)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image.image_id}").read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'SAFE_SEARCH_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # APIレスポンス出力
      response = JSON.parse(response.body)['responses'][0]['safeSearchAnnotation']
      # binding.pry
      # アダルト系、暴力系コンテンツの可能性が高い、もしくは非常に高い場合はtrueで返す
      if response['adult'] == "LIKELY" || response['adult'] == "VERY_LIKELY"
        return true
      elsif response['violence'] == "LIKELY" || response['violence'] == "VERY_LIKELY"
        return true
      else
        return false
      end
    end
  end
end