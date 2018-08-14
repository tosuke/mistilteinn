import 'dart:convert';
import 'package:mistilteinn/model/entities/id.dart';
import 'package:mistilteinn/model/entities/drive_folder.dart';
import 'package:mistilteinn/model/entities/user.dart';

class DriveFileID extends ID {
  DriveFileID(String id) : super(id);
}

class DriveFile {
  final DriveFileID id;
  final DateTime createdAt;
  final UserID userId;
  /// nullable
  final User user;
  final String name;
  final String md5;
  final String type;
  final int datasize;
  final String url;
  /// nullable
  final DriveFolderID folderId;
  /// nullable
  final DriveFolder folder;
  /// default is false
  final bool sensitive;

  DriveFile(
      {this.id,
      this.createdAt,
      this.userId,
      this.user,
      this.name,
      this.md5,
      this.type,
      this.datasize,
      this.url,
      this.folderId,
      this.folder,
      this.sensitive});

  factory DriveFile.fromJSON(Map<String, dynamic> json) => DriveFile(
        id: DriveFileID(json['id']),
        createdAt: DateTime.parse(json['createdAt']),
        userId: UserID(json['userId']),
        user: json.containsKey('user') ? User.fromJSON(json['user']) : null,
        name: json['name'],
        md5: json['md5'],
        type: json['type'],
        datasize: json['datasize'],
        url: json['url'],
        folderId: json.containsKey('folderId')
            ? DriveFolderID(json['folderId'])
            : null,
        folder: json.containsKey('folder')
            ? DriveFolder.fromJSON(json['folder'])
            : null,
        sensitive: json.containsKey('sensitive') ? json['sensitive'] : false,
      );

  Map<String, dynamic> toJSON() => {
        'id': id.toString(),
        'createdAt': createdAt.toIso8601String(),
        'userId': userId.toString(),
        'user': user,
        'name': name,
        'md5': md5,
        'type': type,
        'datasize': datasize,
        'url': url,
        'folderId': folderId.toString(),
        'folder': folder,
        'sensitive': sensitive
      };

  @override
  String toString() => json.encode(this);

  bool operator ==(other) => other is DriveFile ? other.id == id : false;

  int get hashCode => id.hashCode;
}
