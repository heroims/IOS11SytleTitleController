Pod::Spec.new do |s|
s.name                  = 'IOS11SytleTitleController'
s.version               = '1.0'
s.summary               = 'IOS11Sytle Big Title UIViewController  '
s.homepage              = 'https://github.com/heroims/IOS11SytleTitleController'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/IOS11SytleTitleController.git', :tag => "#{s.version}" }
s.platform              = :ios, '7.0'
s.source_files          = 'BigTitleSytleController/*.{h,m}'
s.ios.dependency  	'UIViewControllerScroll'
s.requires_arc          = true
end
