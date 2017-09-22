Pod::Spec.new do |s|
s.name                  = 'UIViewControllerScroll'
s.version               = '1.1'
s.summary               = 'make UIViewController self.view can scroll'
s.homepage              = 'https://github.com/heroims/IOS11SytleTitleController'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/IOS11SytleTitleController.git', :tag => "#{s.version}" }
s.platform              = :ios, '7.0'
s.source_files          = 'UIViewControllerScroll/*.{h,m}'
s.requires_arc          = true
end
