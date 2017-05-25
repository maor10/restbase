Pod::Spec.new do |s|
s.name         = "RESTBase"
s.version      = "0.0.1"
s.summary      = "A short description of RESTBase."

s.description  = <<-DESC
A longer description of NetworkLib in Markdown format.
DESC

s.source = {:git => "https://github.com/maor10/restbase.git", :tag => "0.0.1"} 
s.homepage     = "http://EXAMPLE/NetworkLib"
s.license      = 'MIT'
s.author       = { "Maor Kern" => "maor.kern@gmail.com" }
s.platform     = :ios, '7.0'
s.source_files  = 'RESTBase', 'RESTBase/**/*.{h,m}'
s.public_header_files = 'RESTBase/**/*.h'
s.resources    = "RESTBase/*.png"
s.framework    = 'SystemConfiguration'
s.requires_arc = true

s.dependency 'AFNetworking'

end
