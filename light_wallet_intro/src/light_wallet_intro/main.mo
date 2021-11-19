actor {
    
    var _downLoadTime : Nat = 0;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    public func downLoad() : async Nat {
     _downLoadTime :=_downLoadTime +1;
     return _downLoadTime;
    };

    public func getDownLoadNum() : async Nat{
        return _downLoadTime;
    };
};
