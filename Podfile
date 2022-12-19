# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'XLTestDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for XLTestDemo
  pod 'HandyJSON'
  pod 'SwiftyJSON'
  pod 'SnapKit'
  pod 'Kingfisher', '~> 4.10.1'
  pod 'SnapKitExtend'
  pod 'Then'
  pod 'MJRefresh'
  pod 'MBProgressHUD'
  pod 'IQKeyboardManagerSwift'
  pod 'Moya', '~> 13.0.1'
  pod 'Reusable'
  pod 'EmptyDataSet-Swift'
  pod 'JXSegmentedView'
  pod 'SwiftMessages'
  pod 'DNSPageView', '~> 1.0.1'
  #banner滚动图片
  pod 'FSPagerView'
  #滚动页
  pod 'LTScrollView'
  #跑马灯
  pod 'JXMarqueeView'
  #播放网络音频
  pod 'StreamingKit'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
  end

  target 'XLTestDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'XLTestDemoUITests' do
    # Pods for testing
  end

end
