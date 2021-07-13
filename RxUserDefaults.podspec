Pod::Spec.new do |s|
  s.name         = "RxUserDefaults"
  s.version      = "3.0.0"
  s.license      = "MIT"
  s.summary      = "Rx for UserDefaults"
  s.homepage     = "https://github.com/marcbaldwin/RxUserDefaults"
  s.author       = { "Marc Baldwin" => "marc.baldwin88@gmail.com" }
  s.source       = { :git => "https://github.com/marcbaldwin/RxUserDefaults.git", :tag => s.version }
  s.source_files = "RxUserDefaults/*.swift"
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.frameworks   = "Foundation"
  s.dependency     'RxSwift', '~> 6'
end
