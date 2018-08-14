import 'dart:convert';
import 'package:mistilteinn/model/entities/id.dart';
import 'package:mistilteinn/model/entities/drive_file.dart';
import 'package:mistilteinn/model/entities/note.dart';

class UserID extends ID {
  UserID(String id) : super(id);
}

class User {
  final UserID id;
  final DateTime createdAt;
  final String username;
  final String description;

  /// nullable
  final DriveFileID avatarId;
  final String avatarUrl;

  /// nullable
  final DriveFileID bannerId;
  final String bannerUrl;
  final int followersCount;
  final int followingCount;

  /// default is false
  final bool isFollowing;

  /// default is false
  final bool isFollowed;

  /// default is false
  final bool isMuted;
  final int notesCount;

  /// nullable
  final NoteID pinnedNoteId;

  /// nullable
  final Note pinnedNote;

  /// nullable
  final String host;

  /// nullable
  final _Twitter twitter;

  final bool isCat;
  final bool isBot;

  final _Profile profile;

  User({
    this.id,
    this.createdAt,
    this.username,
    this.description,
    this.avatarId,
    this.avatarUrl,
    this.bannerId,
    this.bannerUrl,
    this.followersCount,
    this.followingCount,
    this.isFollowing,
    this.isFollowed,
    this.isMuted,
    this.notesCount,
    this.pinnedNote,
    this.pinnedNoteId,
    this.host,
    this.isBot,
    this.isCat,
    this.twitter,
    this.profile,
  });

  factory User.fromJSON(Map<String, dynamic> json) => User(
      id: UserID(json['id']),
      createdAt: DateTime.parse(json['createdAt']),
      username: json['username'],
      description: json['description'],
      avatarId:
          json.containsKey('avatarId') ? DriveFileID(json['avatarId']) : null,
      avatarUrl: json['avatarUrl'],
      bannerId:
          json.containsKey('bannerId') ? DriveFileID(json['bannerId']) : null,
      bannerUrl: json['bannerUrl'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      isFollowing: json['isFollowing'] ?? false,
      isFollowed: json['isFollowed'] ?? false,
      isMuted: json['isMuted'] ?? false,
      notesCount: json['notesCount'],
      pinnedNote: json.containsKey('pinnedNote')
          ? Note.fromJSON(json['pinnedNote'])
          : null,
      pinnedNoteId: json.containsKey('pinnedNoteId')
          ? NoteID(json['pinnedNoteId'])
          : null,
      host: json['host'],
      twitter: json.containsKey('twitter')
          ? _Twitter.fromJSON(json['twitter'])
          : null,
      isBot: json['isBot'] ?? false,
      isCat: json['isCat'] ?? false,
      profile: _Profile.fromJSON(json['profile']));

  Map<String, dynamic> toJSON() => {
        'id': id.toString(),
        'createdAt': createdAt.toIso8601String(),
        'username': username,
        'description': description,
        'avatarId': avatarId.toString(),
        'avatarUrl': avatarUrl,
        'bannerId': bannerId.toString(),
        'bannerUrl': bannerUrl,
        'followersCount': followersCount,
        'followingCount': followingCount,
        'isFollowing': isFollowing,
        'isFollowed': isFollowed,
        'isMuted': isMuted,
        'notesCount': notesCount,
        'pinnedNote': pinnedNote,
        'pinnenNoteId': pinnedNoteId.toString(),
        'host': host,
        'twitter': twitter,
        'isBot': isBot,
        'isCat': isCat,
        'profile': profile
      };

  @override
  String toString() => json.encode(this);

  bool operator ==(other) => other is User ? other.id == id : false;
  int get hashCode => id.hashCode;
}

class _Twitter {
  final String userId;
  final String screenName;

  _Twitter({this.userId, this.screenName});

  _Twitter.fromJSON(Map<String, dynamic> json)
      : userId = json['userId'],
        screenName = json['screenName'];

  Map<String, dynamic> toJSON() => {
        'userId': userId,
        'screenName': screenName,
      };

  @override
  String toString() => json.encode(this);
}

class _Profile {
  /// nullable
  final String location;

  /// nullable
  final String birthday;

  _Profile({this.location, this.birthday});

  _Profile.fromJSON(Map<String, dynamic> json)
      : location = json['location'],
        birthday = json['birthday'];
  @override
  String toString() => json.encode(this);
}
