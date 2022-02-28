import 'package:hive_flutter/hive_flutter.dart';

part 'contacts.g.dart';

@HiveType(typeId: 0)
class Contacts {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? number;
  Contacts({this.name, this.number});
}
