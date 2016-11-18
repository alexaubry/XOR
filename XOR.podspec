Pod::Spec.new do |s|

  s.name         = "XOR"
  s.version      = "1.0.0"
  s.summary      = "A Swift Library to compute the eXclusive OR of two messages"

  s.description  = <<-DESC
With XOR, computing the exclusive OR of two Integer arrays becomes as easy as calling `xor(key:)`.
                    DESC

  s.homepage     = "https://github.com/alexaubry/XOR"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexis Aubry Radanovic" => "aleks@alexis-aubry-radanovic.me" }
  s.social_media_url   = "http://twitter.com/leksantoine"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/alexaubry/XOR.git", :tag => "#{s.version}" }
  s.source_files  = "Sources"

end
