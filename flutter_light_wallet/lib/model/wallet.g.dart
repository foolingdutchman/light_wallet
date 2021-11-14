// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletAdapter extends TypeAdapter<Wallet> {
  @override
  final int typeId = 0;

  @override
  Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallet(
      (fields[5] as List).cast<Token>(),
      password: fields[0] as dynamic,
      secrectKey: fields[1] as dynamic,
      principal: fields[2] as dynamic,
      address: fields[4] as dynamic,
      mnomenic: fields[3] as dynamic,
      guesturePassword: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Wallet obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.secrectKey)
      ..writeByte(2)
      ..write(obj.principal)
      ..writeByte(3)
      ..write(obj.mnomenic)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.tokenList)
      ..writeByte(6)
      ..write(obj.guesturePassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
