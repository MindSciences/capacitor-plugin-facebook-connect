import { registerPlugin } from '@capacitor/core';

import type { ExamplePlugin } from './definitions';

const Example = registerPlugin<ExamplePlugin>('Example', {
  // @todo remove web implementation or add `this.unimplemented('Not implemented on web.');`
  web: () => import('./web').then(m => new m.ExampleWeb()),
});

export * from './definitions';
export { Example };
