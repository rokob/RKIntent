Pod::Spec.new do |s|
  s.name             = "RKIntent"
  s.version          = "0.1.0"
  s.summary          = "RKIntent - app routing based on android intents"
  s.description      = <<-DESC
                       =RKIntent

                       This is a library built with the spirit of Android intents,
                       with the purpose of simplifying navigation in complicated
                       apps.
                       DESC
  s.homepage         = "https://github.com/rokob/RKIntent"
  s.license          = 'MIT'
  s.author           = { "Andrew Ledvina" => "wvvwwvw@gmail.com" }
  s.source           = { :git => "https://github.com/rokob/RKIntent.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wolfgangfabian'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'RKIntent/RKIntent'
  s.resources = 'Assets'

  s.public_header_files = 'RKIntent/RKIntent/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
end
