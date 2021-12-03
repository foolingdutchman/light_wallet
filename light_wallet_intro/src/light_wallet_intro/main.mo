import Prim "mo:⛔";
import ExperimentalCycles "mo:base/ExperimentalCycles";
import Array "mo:base/Array";

shared({ caller = hub }) actor class Hub() = this {
    
    var _android_downLoadTime : Nat = 0;
    var _ios_downLoadTime : Nat = 0;
    stable var contractOwners : [Principal] = [hub];
     stable var INITALIZED : Bool = false;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    public func downLoad() : async Nat {
     _android_downLoadTime :=_android_downLoadTime +1;
     return _android_downLoadTime;
    };

    public func getDownLoadNum() : async Nat{
        return _android_downLoadTime;
    };
    public func iosDownLoad() : async Nat {
     _ios_downLoadTime :=_ios_downLoadTime +1;
     return _ios_downLoadTime;
    };

    public func getIOSDownLoadNum() : async Nat{
        return _ios_downLoadTime;
    };

    public shared({caller}) func init(
        android_downLoadTime   : Nat,
        ios_downLoadTime : Nat,
        owners   : [Principal],
    ) : async () {
        assert(not INITALIZED );
        _android_downLoadTime    := android_downLoadTime;
        _ios_downLoadTime := ios_downLoadTime;
        contractOwners    := Array.append(contractOwners, owners);
        INITALIZED        := true;
    };

    public type ContractInfo = {
        heap_size : Nat; 
        memory_size : Nat;
        max_live_size : Nat;
        cycles : Nat;     
    };

    public func getOwner() :async Principal{
        return hub;
    };

    // Returns the contract info.
    // @pre: isOwner
    public shared ({caller}) func getContractInfo() : async ContractInfo {
        assert(_isOwner(caller));
        return {
            heap_size        = Prim.rts_heap_size();
            memory_size      = Prim.rts_memory_size();
            max_live_size    = Prim.rts_max_live_size();
            cycles           = ExperimentalCycles.balance();
        };
    };

    private func _isOwner(p : Principal) : Bool {
        switch(Array.find<Principal>(contractOwners, func(v) {return v == p})) {
            case (null) { false; };
            case (? v)  { true;  };
        };
    };

};
