import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
         let methodChannel = FlutterMethodChannel(name: "flutter_to_native",
                                                   binaryMessenger: controller.binaryMessenger)
      methodChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if(call.method == "decrypt") {
              let encrypted = call.arguments as! NSDictionary
let res = AESEncryptionDecryption().DecryptAstring(encrypted["data"] as! String)
result(res)

  }else if(call.method == "encrypt"){
    let data = call.arguments as! NSDictionary
  let res = AESEncryptionDecryption().EncryptAstring(data["data"] as! String)
  result(res)
  }else{
      result(FlutterMethodNotImplemented)
    return
  }


         })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
