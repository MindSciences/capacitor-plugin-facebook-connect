#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

@import FBSDKCoreKit;

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(FacebookConnect, "FacebookConnect",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(logEvent, CAPPluginReturnPromise);
)
