Pod::Spec.new do |s|
  s.name         = "RxUserDefaults"
  s.version      = "1.2.0"
  s.license      = "MIT"
  s.summary      = "Rx for UserDefaults"
  s.homepage     = "https://github.com/marcbaldwin/RxUserDefaults"
  s.author       = { "Marc Baldwin" => "marc.baldwin88@gmail.com" }
  s.source       = { :git => "https://github.com/marcbaldwin/RxUserDefaults.git", :tag => s.version }
  s.source_files = "RxUserDefaults/*.swift"
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.frameworks   = "Foundation"
  s.dependency 'RxSwift', '~> 4.0'

end
