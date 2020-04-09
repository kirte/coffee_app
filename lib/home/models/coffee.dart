import 'package:json_annotation/json_annotation.dart';
part 'coffee.g.dart';

@JsonSerializable()
class Coffee{
  final String name;
  final String sugars;
  final int strength;

  Coffee({ this.name="new crew member", this.sugars="0", this.strength=100 });
  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeToJson(this);

}