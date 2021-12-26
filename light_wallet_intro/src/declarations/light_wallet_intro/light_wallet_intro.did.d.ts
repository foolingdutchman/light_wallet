import type { Principal } from '@dfinity/principal';
export interface Apk {
  'data' : Array<number>,
  'name' : string,
  'suffix' : string,
}
export interface ApkInfo {
  'name' : string,
  'size' : bigint,
  'suffix' : string,
  'bufferSize' : bigint,
}
export interface ContractInfo {
  'memory_size' : bigint,
  'max_live_size' : bigint,
  'cycles' : bigint,
  'admins' : Array<[string, string]>,
  'heap_size' : bigint,
}
export interface Hub {
  'addAdmin' : (arg_0: string, arg_1: string) => Promise<boolean>,
  'downLoad' : () => Promise<bigint>,
  'getApk' : () => Promise<Array<Apk>>,
  'getApkBuffer' : (arg_0: bigint) => Promise<Array<number>>,
  'getApkInfo' : () => Promise<ApkInfo>,
  'getContractInfo' : () => Promise<ContractInfo>,
  'getDownLoadNum' : () => Promise<bigint>,
  'getIOSDownLoadNum' : () => Promise<bigint>,
  'getOwner' : () => Promise<Principal>,
  'greet' : (arg_0: string) => Promise<string>,
  'init' : (arg_0: bigint, arg_1: bigint, arg_2: Array<Principal>) => Promise<
      undefined
    >,
  'iosDownLoad' : () => Promise<bigint>,
  'updateAndroidDownLoadNum' : (arg_0: bigint) => Promise<boolean>,
  'updateApk' : (
      arg_0: string,
      arg_1: string,
      arg_2: Array<number>,
      arg_3: string,
    ) => Promise<Result>,
  'updateApkFinish' : (arg_0: string, arg_1: string, arg_2: string) => Promise<
      boolean
    >,
  'updateBuffer' : (
      arg_0: string,
      arg_1: string,
      arg_2: Array<number>,
    ) => Promise<boolean>,
  'updateIOSdownLoadNum' : (arg_0: bigint) => Promise<boolean>,
}
export type Result = { 'ok' : null } |
  { 'err' : string };
export interface _SERVICE extends Hub {}
