export const idlFactory = ({ IDL }) => {
  const Apk = IDL.Record({
    'data' : IDL.Vec(IDL.Nat8),
    'name' : IDL.Text,
    'suffix' : IDL.Text,
  });
  const ApkInfo = IDL.Record({
    'name' : IDL.Text,
    'size' : IDL.Nat,
    'suffix' : IDL.Text,
    'bufferSize' : IDL.Nat,
  });
  const ContractInfo = IDL.Record({
    'memory_size' : IDL.Nat,
    'max_live_size' : IDL.Nat,
    'cycles' : IDL.Nat,
    'admins' : IDL.Vec(IDL.Tuple(IDL.Text, IDL.Text)),
    'heap_size' : IDL.Nat,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Hub = IDL.Service({
    'addAdmin' : IDL.Func([IDL.Text, IDL.Text], [IDL.Bool], []),
    'downLoad' : IDL.Func([], [IDL.Nat], []),
    'getApk' : IDL.Func([], [IDL.Vec(Apk)], []),
    'getApkBuffer' : IDL.Func([IDL.Nat], [IDL.Vec(IDL.Nat8)], []),
    'getApkInfo' : IDL.Func([], [ApkInfo], []),
    'getContractInfo' : IDL.Func([], [ContractInfo], []),
    'getDownLoadNum' : IDL.Func([], [IDL.Nat], []),
    'getIOSDownLoadNum' : IDL.Func([], [IDL.Nat], []),
    'getOwner' : IDL.Func([], [IDL.Principal], []),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
    'init' : IDL.Func([IDL.Nat, IDL.Nat, IDL.Vec(IDL.Principal)], [], []),
    'iosDownLoad' : IDL.Func([], [IDL.Nat], []),
    'updateAndroidDownLoadNum' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'updateApk' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Vec(IDL.Nat8), IDL.Text],
        [Result],
        [],
      ),
    'updateApkFinish' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text],
        [IDL.Bool],
        [],
      ),
    'updateBuffer' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Vec(IDL.Nat8)],
        [IDL.Bool],
        [],
      ),
    'updateIOSdownLoadNum' : IDL.Func([IDL.Nat], [IDL.Bool], []),
  });
  return Hub;
};
export const init = ({ IDL }) => { return []; };
