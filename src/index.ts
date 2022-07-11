import { registerPlugin } from '@capacitor/core';

import type { FacebookConnectPlugin } from './definitions';

const FacebookConnect = registerPlugin<FacebookConnectPlugin>('FacebookConnect', {
  // @todo remove web implementation or add `this.unimplemented('Not implemented on web.');`
  web: () => import('./web').then(m => new m.FacebookConnectWeb()),
});

export * from './definitions';
export { FacebookConnect };
