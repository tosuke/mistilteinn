import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:mistilteinn/model/entities/id.dart';
import 'package:mistilteinn/model/entities/user.dart';

class DriveFolderID extends ID {
  DriveFolderID(String id) : super(id);
}

class DriveFolder {
  final DriveFolderID id;
  final DateTime createdAt;
  final UserID userId;
  /// nullable
  final DriveFolderID parentId;
  final String name;

  DriveFolder({
    @required this.id,
    @required this.createdAt,
    @required this.userId,
    this.parentId,
    @required this.name,
  });

  factory DriveFolder.fromJSON(Map<String, dynamic> json) => DriveFolder(
      id: DriveFolderID(json['id']),
      createdAt: DateTime.parse(json['createdAt']),
      userId: UserID(json['userId']),
      parentId:
          json.containsKey('parentId') ? DriveFolderID(json['parentID']) : null,
      name: json['name']);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'createdAt': createdAt.toIso8601String(),
        'userId': userId.toString(),
        'parentId': parentId.toString(),
        'name': name,
      };

  @override
  String toString() => json.encode(this.toJson());

  bool operator ==(other) => other is DriveFolder ? other.id == id : false;

  int get hashCode => id.hashCode;
}
