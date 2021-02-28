Pod::Spec.new do |s|
  s.name     = 'CodableBloomFilter'
  s.version  = '1.0.0'
  s.summary  = "An implementation of the Bloom filter data structure conforming to Swift's Codable serialization protocol"
  s.homepage = 'https://github.com/metabolist/codable-bloom-filter'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { 'Metabolist' => 'info@metabolist.org' }
  s.source   = { :git => 'https://github.com/metabolist/codable-bloom-filter.git', :tag => "v#{s.version}" }

  s.swift_versions = ['5.2']
  s.ios.deployment_target     = '9.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

  s.source_files = 'Sources/CodableBloomFilter/**/*'
end
