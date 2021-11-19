import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'downLoad' : () => Promise<bigint>,
  'getDownLoadNum' : () => Promise<bigint>,
  'greet' : (arg_0: string) => Promise<string>,
}
