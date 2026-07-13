import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
    // MARK: - Properties
    private var secureField: UITextField?
    private var isScreenProtected = false
    private var recordingBlurView: UIVisualEffectView?
    private var appSwitcherBlurView: UIVisualEffectView?
    private var methodChannel: FlutterMethodChannel?

    // MARK: - App Lifecycle

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)

        // 🔒 Layer 1: Screenshot prevention (makes screenshots black)
        DispatchQueue.main.async { [weak self] in
            self?.preventScreenCapture()
        }
        // Retry after 1s in case Flutter's window wasn't fully ready on first attempt
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.preventScreenCapture()
        }

        // 🔒 Layer 2: Screen recording detection
        setupScreenRecordingProtection()

        // 🔒 Layer 3: Screenshot taken detection (shows warning)
        setupScreenshotTakenDetection()

        // 🔒 Layer 4: App switcher / task switcher blur
        setupAppSwitcherProtection()

        // 🔒 Layer 5: External display / AirPlay mirroring detection
        setupExternalDisplayProtection()

        return result
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
        // Setup Flutter MethodChannel after engine is ready
        setupMethodChannel()
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
        preventScreenCapture()
        handleScreenCapturedDidChange()
        hideAppSwitcherBlur()
    }

    override func applicationWillResignActive(_ application: UIApplication) {
        super.applicationWillResignActive(application)
        showAppSwitcherBlur()
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - 🔒 Layer 1: Screenshot Prevention (Black Screenshot)
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Uses the UITextField.isSecureTextEntry trick to make the window's content
    /// render as black in screenshots and screen recordings at the OS level.
    private func preventScreenCapture() {
        guard let window = self.window, !isScreenProtected else { return }

        let field = UITextField()
        field.isSecureTextEntry = true
        field.isUserInteractionEnabled = false
        field.translatesAutoresizingMaskIntoConstraints = false

        window.addSubview(field)
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            field.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            field.topAnchor.constraint(equalTo: window.topAnchor),
            field.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])

        // Force layout so the secure sublayer (_UITextLayoutCanvasView) is created
        window.layoutIfNeeded()

        // Move the window's layer into the secure sublayer
        if let windowSuperlayer = window.layer.superlayer,
           let secureLayer = field.layer.sublayers?.first {
            windowSuperlayer.addSublayer(field.layer)
            secureLayer.addSublayer(window.layer)
            isScreenProtected = true
            secureField = field
        }
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - 🔒 Layer 2: Screen Recording Detection
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Detects when the screen is being recorded and shows a blocking overlay.
    func setupScreenRecordingProtection() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleScreenCapturedDidChange),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
        handleScreenCapturedDidChange()
    }

    @objc func handleScreenCapturedDidChange() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let isCaptured = UIScreen.main.isCaptured
            let hasExternalDisplay = UIScreen.screens.count > 1

            if isCaptured || hasExternalDisplay {
                self.showScreenRecordingWarning()
                self.methodChannel?.invokeMethod("onScreenCaptureStarted", arguments: [
                    "isRecording": isCaptured,
                    "hasExternalDisplay": hasExternalDisplay
                ])
            } else {
                self.hideScreenRecordingWarning()
                self.methodChannel?.invokeMethod("onScreenCaptureStopped", arguments: nil)
            }
        }
    }

    func showScreenRecordingWarning() {
        guard let window = self.window else { return }

        if recordingBlurView == nil {
            let blurEffect = UIBlurEffect(style: .dark)
            let effectView = UIVisualEffectView(effect: blurEffect)
            effectView.frame = window.bounds
            effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            // 🔒 Icon
            let iconLabel = UILabel()
            iconLabel.text = "🔒"
            iconLabel.font = UIFont.systemFont(ofSize: 60)
            iconLabel.translatesAutoresizingMaskIntoConstraints = false

            // Title
            let titleLabel = UILabel()
            titleLabel.text = "Content Protected"
            titleLabel.textColor = .white
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            // Subtitle
            let subtitleLabel = UILabel()
            subtitleLabel.text = "Screen recording and mirroring\nare not allowed in this app."
            subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.7)
            subtitleLabel.font = UIFont.systemFont(ofSize: 16)
            subtitleLabel.textAlignment = .center
            subtitleLabel.numberOfLines = 0
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

            let stack = UIStackView(arrangedSubviews: [iconLabel, titleLabel, subtitleLabel])
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 12
            stack.translatesAutoresizingMaskIntoConstraints = false

            effectView.contentView.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
                stack.leadingAnchor.constraint(greaterThanOrEqualTo: effectView.contentView.leadingAnchor, constant: 32),
                stack.trailingAnchor.constraint(lessThanOrEqualTo: effectView.contentView.trailingAnchor, constant: -32)
            ])

            recordingBlurView = effectView
        }

        if let blurView = recordingBlurView, blurView.superview == nil {
            window.addSubview(blurView)
            window.bringSubviewToFront(blurView)
        }
    }

    func hideScreenRecordingWarning() {
        recordingBlurView?.removeFromSuperview()
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - 🔒 Layer 3: Screenshot Taken Detection
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Detects when a screenshot has been taken and shows a warning toast.
    /// Note: This cannot prevent the screenshot but alerts the user.
    func setupScreenshotTakenDetection() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleScreenshotTaken),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
    }

    @objc func handleScreenshotTaken() {
        // Notify Flutter side
        methodChannel?.invokeMethod("onScreenshotTaken", arguments: nil)

        // Show a warning toast
        showScreenshotWarningToast()
    }

    private func showScreenshotWarningToast() {
        guard let window = self.window else { return }

        let toastView = UIView()
        toastView.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 0.95)
        toastView.layer.cornerRadius = 12
        toastView.clipsToBounds = true
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false

        let iconLabel = UILabel()
        iconLabel.text = "⚠️"
        iconLabel.font = UIFont.systemFont(ofSize: 24)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false

        let textLabel = UILabel()
        textLabel.text = "Screenshots are not allowed"
        textLabel.textColor = .white
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        let hStack = UIStackView(arrangedSubviews: [iconLabel, textLabel])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.spacing = 10
        hStack.translatesAutoresizingMaskIntoConstraints = false

        toastView.addSubview(hStack)
        window.addSubview(toastView)
        window.bringSubviewToFront(toastView)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 14),
            hStack.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -14),
            hStack.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),

            toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastView.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        // Animate in, hold, then animate out
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            toastView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 2.5, options: [], animations: {
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - 🔒 Layer 4: App Switcher Protection
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Hides app content in the iOS task switcher (multitasking view)
    /// by overlaying a blur when the app goes to background.
    func setupAppSwitcherProtection() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    @objc private func appMovedToBackground() {
        showAppSwitcherBlur()
    }

    @objc private func appMovedToForeground() {
        hideAppSwitcherBlur()
    }

    private func showAppSwitcherBlur() {
        guard let window = self.window else { return }

        if appSwitcherBlurView == nil {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = window.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.tag = 9999
            appSwitcherBlurView = blurView
        }

        if let blurView = appSwitcherBlurView, blurView.superview == nil {
            window.addSubview(blurView)
            window.bringSubviewToFront(blurView)
        }
    }

    private func hideAppSwitcherBlur() {
        UIView.animate(withDuration: 0.2) {
            self.appSwitcherBlurView?.alpha = 0
        } completion: { _ in
            self.appSwitcherBlurView?.removeFromSuperview()
            self.appSwitcherBlurView?.alpha = 1
        }
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - 🔒 Layer 5: External Display / AirPlay Protection
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Detects when an external display or AirPlay mirror is connected.
    func setupExternalDisplayProtection() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleExternalDisplayChange),
            name: UIScreen.didConnectNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleExternalDisplayChange),
            name: UIScreen.didDisconnectNotification,
            object: nil
        )

        // Check on launch
        checkExternalDisplay()
    }

    @objc private func handleExternalDisplayChange() {
        checkExternalDisplay()
    }

    private func checkExternalDisplay() {
        DispatchQueue.main.async { [weak self] in
            let hasExternalDisplay = UIScreen.screens.count > 1
            if hasExternalDisplay {
                self?.showScreenRecordingWarning()
                self?.methodChannel?.invokeMethod("onExternalDisplayConnected", arguments: nil)
            } else if !UIScreen.main.isCaptured {
                self?.hideScreenRecordingWarning()
            }
        }
    }

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // MARK: - Flutter MethodChannel
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    /// Sets up a MethodChannel to communicate screen protection events to Flutter.
    /// Flutter side can listen on "com.app/screen_protection" channel.
    private func setupMethodChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else { return }
        methodChannel = FlutterMethodChannel(
            name: "com.app/screen_protection",
            binaryMessenger: controller.binaryMessenger
        )
    }
}
