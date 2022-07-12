import Foundation
import Capacitor

import FBSDKCoreKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FacebookConnect)
public class FacebookConnect: CAPPlugin {
    private let implementation = Example()
    private var applicationWasActivated = false

    override public func load() {
      print("FacebookConnect plugin: Loaded")

      NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.orientationDidChange),
        name: UIDevice.orientationDidChangeNotification,
        object: nil
      )

      NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.applicationDidFinishLaunching(_:)),
        name: UIApplication.didFinishLaunchingNotification,
        object: nil
      )

      NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.applicationDidBecomeActive(_:)),
        name: UIApplication.didBecomeActiveNotification,
        object: nil
      )
    }

    @objc func applicationDidFinishLaunching(_ notification: Notification) {
        // @todo confirm this is correct
        var launchOptions = notification.userInfo as NSDictionary? as? [UIApplication.LaunchOptionsKey: Any];

        if launchOptions == nil {
            launchOptions = [:]
        }

        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: launchOptions)

        Profile.enableUpdatesOnAccessTokenChange(true)
    }

    @objc func applicationDidBecomeActive(_ notification: Notification) {
        if Settings.shared.isAutoLogAppEventsEnabled {
            AppEvents.shared.activateApp()
        }
        if self.applicationWasActivated == false {
            self.applicationWasActivated = true
//            self.enableHybridAppEvents() // @todo implement this
        }
    }

    @objc func orientationDidChange() {
      print("orientation changed! yey!")
    }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func logEvent(_ call: CAPPluginCall) {
//        Settings.shared.isAdvertiserTrackingEnabled = true;

        let eventName = call.getString("eventName") ?? ""
        let parameters = call.getObject("parameters") // @todo pass paramenets to appevents

        print("about to log event at facebook: " + eventName)

        AppEvents.shared.logEvent(AppEvents.Name(eventName))

        call.resolve([
            "result": eventName
        ])
    }
}
