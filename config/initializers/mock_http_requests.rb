# frozen_string_literal: true

if Rails.configuration.use_mocks_please
  require 'webmock'
  include WebMock::API

  WebMock.enable!

  stub_request(:get, %r{recipepuppy\.com/api/})
    .to_return do |request|
    matched_result = request.uri.query.match(/q=(.*)/)
    { body: File.new("#{Rails.root}/spec/mocks/#{matched_result[1]}.json"), status: 200 }
  end
end
