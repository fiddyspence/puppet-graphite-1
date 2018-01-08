require 'net/http'
require 'uri'
require 'json'
Facter.add('graphitecache') do
  setcode do
    uri = URI.parse("http://localhost:8500/v1/catalog/service/carboncache")
    JSON::parse(Net::HTTP.get_response(uri).body)
  end
end
Facter.add('graphitecachehosts') do
  setcode do
    cachenodes = Facter.value(:graphitecache)
    cachenodes.map { |node| node['Node'] }
  end
end
Facter.add('graphitecacheaddresses') do
  setcode do
    cachenodes = Facter.value(:graphitecache)
    cachenodes.map { |node| { node['Node'] => node['Address'] }}
  end
end
