import Prim "mo:⛔";
import ExperimentalCycles "mo:base/ExperimentalCycles";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import ArrayHelper "./arrayHelper";

shared({ caller = hub }) actor class Hub() = this {
     
     
     public type Apk ={
        name : Text;
        suffix : Text;
        data : [Nat8];
    };

    public type ApkInfo={
        size :Nat;
        bufferSize :Nat;
        name : Text;
        suffix : Text;
    };
    
    stable var _android_downLoadTime : Nat = 0;
    stable var _ios_downLoadTime : Nat = 0;
    stable var contractOwners : [Principal] = [hub];
     stable var INITALIZED : Bool = false;
     stable var _admins :[(Text,Text)] =[];
     stable var apks :[Apk] =[];
     var stageData :[Nat8] =[];
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
         assert(not INITALIZED );
        return _ios_downLoadTime;
    };

    public shared ({caller}) func updateAndroidDownLoadNum(num : Nat): async Bool{
         assert(_isOwner(caller));
        _android_downLoadTime := num;

        return true;

    };

    public shared ({caller}) func updateIOSdownLoadNum(num : Nat) : async Bool{
         assert(_isOwner(caller));
        _ios_downLoadTime := num;

        return true;
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
        admins :[(Text,Text)];    
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
            admins           = _admins;
        };
    };

    private func _isOwner(p : Principal) : Bool {
        switch(Array.find<Principal>(contractOwners, func(v) {return v == p})) {
            case (null) { false; };
            case (? v)  { true;  };
        };
    };

    func _isAdmin(name : Text , password : Text) : Bool {
        switch(Array.find<(Text,Text)>(_admins, func((n,p)) {return n == name})) {
            case (null) { false; };
            case (? (n,p))  { p == password;  };
        };

    };

    public shared ({caller}) func addAdmin( name : Text, password : Text) : async Bool{
          assert(_isOwner(caller));
         _admins := Array.append(_admins,[(name,password)]);
         return true;
    };
    public func updateApk(admin: Text,password : Text , _data: [Nat8] , _name : Text) : async Result.Result<(),Text>{
        if(_isAdmin(admin,password)){
           apks := Array.make({
               name = _name;
               suffix = "apk";
               data =_data;
            }); 
           return #ok();
        }else{
            return #err("Not Authorized");
        }
      
    };

    public func updateBuffer(admin: Text,password : Text, buffer : [Nat8]): async Bool{
         Debug.print ("update called! buffer size :" # Nat.toText(buffer.size())); 
        if(_isAdmin(admin,password)){
           stageData := Array.append(stageData, buffer);
           return true;
        }else{
            return false;
        }
    };

    public func getApk() : async [Apk]{
        apks
    };



    public func getApkBuffer(sliceNum : Nat) :async [Nat8]{
         
        ArrayHelper.copy(apks[0].data,sliceNum*2000000,2000000);

    };

    public func getApkInfo() :async ApkInfo {

        {
             size  = apks[0].data.size();
             bufferSize = 2000000;
             name  = apks[0].name;
             suffix = apks[0].suffix;
        }
    };

    public func updateApkFinish(admin: Text,password : Text,_name : Text): async Bool{
         if(_isAdmin(admin,password)){
             apks := Array.make({
               name = _name;
               suffix = "apk";
               data =stageData;
            }); 
            stageData :=[];
           return true;
        }else{
            return false;
        }
    };

   

};
