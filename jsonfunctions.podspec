Pod::Spec.new do |s|
  s.name = "jsonfunctions"
  s.version = "2.0.0"
  s.summary = "A JsonFunctions Swift library"
  s.description = "A JsonLogic implementation in Swift. JsonLogic is a way to write rules that involve computations in JSON format, these can be applied on JSON data with consistent results. So you can share between server and clients rules in a common format."
  s.homepage = "https://github.com/corona-warn-app/json-functions-swift"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.source = { :git => "https://github.com/corona-warn-app/json-functions-swift.git", :tag => s.version }
  
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.osx.deployment_target = '10.13'

  s.swift_versions = ['5.3.2']
  
  s.cocoapods_version = '>= 1.6.1'
  
  s.frameworks = 'Foundation'
  s.authors = { "Christos Koninis" => "c.koninis@afse.eu",
		"SAP SE or an SAP affiliate company" => "corona-warn-app.opensource@sap.com" }  
  s.source_files = 'Sources/jsonfunctions/**/*.swift'
  s.module_name = 'jsonfunctions'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6'
end
