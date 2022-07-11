interface PluginResult {
  result: any;
}

export interface ExamplePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;

  // @see https://developers.facebook.com/docs/reference/ios/current/class/FBSDKAppEvents/#:~:text=logEvent%3Aparameters%3A,are%20described%20above.
  logEvent(options: {
    eventName: string;
    parameters?: Record<string, any>,
    // @deprecated (not implemented yet)
    valueToSum?: number // @todo implement it
  }): Promise<PluginResult>;
}
