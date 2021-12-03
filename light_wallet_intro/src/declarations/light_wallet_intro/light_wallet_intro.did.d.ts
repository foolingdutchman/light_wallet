import type { Principal } from '@dfinity/principal';
export interface ContractInfo {
  'memory_size' : bigint,
  'max_live_size' : bigint,
  'cycles' : bigint,
  'heap_size' : bigint,
}
export interface Hub {
  'downLoad' : () => Promise<bigint>,
  'getContractInfo' : () => Promise<ContractInfo>,
  'getDownLoadNum' : () => Promise<bigint>,
  'getIOSDownLoadNum' : () => Promise<bigint>,
  'getOwner' : () => Promise<Principal>,
  'greet' : (arg_0: string) => Promise<string>,
  'init' : (arg_0: bigint, arg_1: bigint, arg_2: Array<Principal>) => Promise<
      undefined
    >,
  'iosDownLoad' : () => Promise<bigint>,
}
export interface _SERVICE extends Hub {}
