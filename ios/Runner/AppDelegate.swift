import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  var blurView: UIVisualEffectView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    // 🔒 Prevent screenshots (this makes screenshots black)
    if let window = self.window {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        window.addSubview(textField)
        textField.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        window.layer.superlayer?.addSublayer(textField.layer)
        textField.layer.sublayers?.first?.addSublayer(window.layer)
    }
    
    setupScreenRecordingProtection()
    
    return result
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  func setupScreenRecordingProtection() {
      NotificationCenter.default.addObserver(self, selector: #selector(handleScreenCapturedDidChange), name: UIScreen.capturedDidChangeNotification, object: nil)
      handleScreenCapturedDidChange()
  }
  
  @objc func handleScreenCapturedDidChange() {
      let isCaptured = UIScreen.main.isCaptured
      if isCaptured {
          showScreenRecordingWarning()
      } else {
          hideScreenRecordingWarning()
      }
  }
  
  func showScreenRecordingWarning() {
      guard let window = self.window else { return }
      
      if blurView == nil {
          let blurEffect = UIBlurEffect(style: .dark)
          let effectView = UIVisualEffectView(effect: blurEffect)
          effectView.frame = window.bounds
          effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          
          let label = UILabel()
          label.text = "Screen recording is not allowed."
          label.textColor = .white
          label.font = UIFont.boldSystemFont(ofSize: 22)
          label.textAlignment = .center
          label.numberOfLines = 0
          
          label.translatesAutoresizingMaskIntoConstraints = false
          effectView.contentView.addSubview(label)
          
          NSLayoutConstraint.activate([
              label.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
              label.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
              label.leadingAnchor.constraint(greaterThanOrEqualTo: effectView.contentView.leadingAnchor, constant: 16),
              label.trailingAnchor.constraint(lessThanOrEqualTo: effectView.contentView.trailingAnchor, constant: -16)
          ])
          
          blurView = effectView
      }
      
      if let blurView = blurView, blurView.superview == nil {
          window.addSubview(blurView)
          window.bringSubviewToFront(blurView)
      }
  }
  
  func hideScreenRecordingWarning() {
      blurView?.removeFromSuperview()
  }
}
