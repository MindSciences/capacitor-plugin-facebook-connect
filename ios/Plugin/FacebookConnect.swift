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

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func logEvent(_ call: CAPPluginCall) {
//        Settings.shared.isAdvertiserTrackingEnabled = true;


        let eventName = call.getString("eventName") ?? ""

        print("fbfbabout to log event at facebook: " + eventName)

        let parameters: JSObject = call.getObject("parameters") ?? [:]
        var newParameters: [AppEvents.ParameterName:String] = [:]

        for (key, value) in parameters {
            print("fbfbkey: \(key), value: \(value)")
            let key2 = AppEvents.ParameterName(key)
            print("fbfbkey6:", key2, type(of: key), type(of: key2), type(of: value), separator: " || ")
            print("fbfbkey60:", AppEvents.ParameterName.currency, type(of: AppEvents.ParameterName.currency), separator: " || ")

            if value as? String != nil {
                print("fbfb inside")
                newParameters[AppEvents.ParameterName(rawValue: key)] = value as? String
            }
        }

        print("fbfbabout to log event at facebook: " + eventName)
        print(Settings.shared.isAutoLogAppEventsEnabled)
//
//        var launchOptions = notification.userInfo as NSDictionary? as? [UIApplication.LaunchOptionsKey: Any];
//
//        if launchOptions == nil {
//            launchOptions = [:]
//        }

        AppEvents.shared.logEvent(
            AppEvents.Name(eventName), parameters: [
                AppEvents.ParameterName.currency: "USD",
                AppEvents.ParameterName.value: "USD",
            ]
        )

        call.resolve([
            "result": eventName
        ])
    }
}
