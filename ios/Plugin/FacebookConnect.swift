import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FacebookConnect)
public class FacebookConnect: CAPPlugin {
    private let implementation = Example()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func logEvent(_ call: CAPPluginCall) {
        let eventName = call.getString("eventName") ?? ""

        call.resolve([
            "result": eventName
        ])
    }
}
