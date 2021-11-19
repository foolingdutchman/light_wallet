export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'downLoad' : IDL.Func([], [IDL.Nat], []),
    'getDownLoadNum' : IDL.Func([], [IDL.Nat], []),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
