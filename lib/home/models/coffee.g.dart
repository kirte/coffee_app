// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coffee _$CoffeeFromJson(Map<String, dynamic> json) {
  return Coffee(
    name: json['name'] as String,
    sugars: json['sugars'] as String,
    strength: json['strength'] as int,
  );
}

Map<String, dynamic> _$CoffeeToJson(Coffee instance) => <String, dynamic>{
      'name': instance.name,
      'sugars': instance.sugars,
      'strength': instance.strength,
    };
