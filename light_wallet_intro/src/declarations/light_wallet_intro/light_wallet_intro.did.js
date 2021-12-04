export const idlFactory = ({ IDL }) => {
  const ContractInfo = IDL.Record({
    'memory_size' : IDL.Nat,
    'max_live_size' : IDL.Nat,
    'cycles' : IDL.Nat,
    'heap_size' : IDL.Nat,
  });
  const Hub = IDL.Service({
    'downLoad' : IDL.Func([], [IDL.Nat], []),
    'getContractInfo' : IDL.Func([], [ContractInfo], []),
    'getDownLoadNum' : IDL.Func([], [IDL.Nat], []),
    'getIOSDownLoadNum' : IDL.Func([], [IDL.Nat], []),
    'getOwner' : IDL.Func([], [IDL.Principal], []),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
    'init' : IDL.Func([IDL.Nat, IDL.Nat, IDL.Vec(IDL.Principal)], [], []),
    'iosDownLoad' : IDL.Func([], [IDL.Nat], []),
  });
  return Hub;
};
export const init = ({ IDL }) => { return []; };
