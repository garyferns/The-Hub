require File.expand_path('../config/environment', __FILE__)

client = User.first.google_client
gmail_api = client.discovered_api('gmail', 'v1')
batch_results = []
batch = Google::APIClient::BatchRequest.new do |result|
    batch_results << result
end
batch.add(api_method: gmail_api.users.threads.get, parameters: { :userId => 'me', :id => '1508f2a7327fc3b7' })
batch.add(api_method: gmail_api.users.threads.get, parameters: { :userId => 'me', :id => '1508ce784e8d9a14' })
client.execute(batch)
puts batch_results
batch_results[0].data.messages[0].payload.headers.find { |header| header.name == 'From'}.value


