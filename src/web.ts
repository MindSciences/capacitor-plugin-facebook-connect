import { WebPlugin } from '@capacitor/core';

import type { ExamplePlugin } from './definitions';

export class ExampleWeb extends WebPlugin implements ExamplePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async logEvent({ eventName } : { eventName: string }): Promise<any> {
    console.log('facebook sdk not implemented at web');
    return console.log(eventName);
  }
}
