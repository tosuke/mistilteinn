import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:mistilteinn/model/entities/id.dart';
import 'package:mistilteinn/model/entities/user.dart';
import 'package:mistilteinn/model/entities/drive_file.dart';

class NoteID extends ID {
  NoteID(String id) : super(id);
}

class Note {
  final NoteID id;
  final DateTime createdAt;

  /// default is false
  final bool viaMobile;

  /// default is ''
  final String text;

  /// default is []
  final List<DriveFileID> mediaIds;

  /// default is []
  final List<DriveFile> media;
  final UserID userId;

  /// nullable
  final User user;

  /// nullable
  final String myReaction;
  final Map<String, int> reactionCounts;

  /// nullable
  final NoteID replyId;

  /// nullable
  final Note reply;

  /// nullable
  final NoteID renoteId;

  /// nullable
  final Note renote;

  /// nullable
  final _Poll poll;

  /// nullable
  final _Geo geo;

  Note(
      {this.id,
      this.createdAt,
      this.viaMobile,
      this.text,
      this.mediaIds,
      this.media,
      this.userId,
      this.user,
      this.myReaction,
      this.reactionCounts,
      this.replyId,
      this.reply,
      this.renoteId,
      this.renote,
      this.poll,
      this.geo});

  factory Note.fromJSON(Map<String, dynamic> json) => Note(
      id: NoteID(json['id']),
      createdAt: DateTime.parse(json['createdAt']),
      viaMobile: json['viaMobile'] ?? false,
      text: json['text'] ?? '',
      mediaIds: ((json['mediaIds'] ?? []) as List<String>)
          .map((id) => DriveFileID(id))
          .toList(),
      media: ((json['media'] ?? []) as List<Map<String, dynamic>>)
          .map((obj) => DriveFile.fromJSON(obj))
          .toList(),
      userId: json['userId'],
      user: json.containsKey('user') ? User.fromJSON(json['user']) : null,
      myReaction: json['myReaction'],
      reactionCounts: json['reactionCounts'],
      replyId: json.containsKey('replyId') ? NoteID(json['replyId']) : null,
      reply: json.containsKey('reply') ? Note.fromJSON(json['reply']) : null,
      renoteId: json.containsKey('renoteId') ? NoteID(json['renoteId']) : null,
      renote: json.containsKey('renote') ? Note.fromJSON(json['renote']) : null,
      poll: json.containsKey('poll') ? _Poll.fromJSON(json['poll']) : null,
      geo: json.containsKey('geo') ? _Geo.fromJSON(json['geo']) : null);

  Map<String, dynamic> toJSON() => {
        'id': id.toString(),
        'createdAt': createdAt.toIso8601String(),
        'viaMobile': viaMobile,
        'text': text,
        'mediaIds': mediaIds,
        'media': media,
        'userId': userId,
        'user': user,
        'myReaction': myReaction,
        'reactionCounts': reactionCounts,
        'replyId': replyId.toString(),
        'reply': reply,
        'renoteId': renoteId.toString(),
        'renote': renote,
        'poll': poll,
        'geo': geo
      };

  @override
  String toString() => json.encode(this);

  bool operator ==(other) => other is Note ? other.id == id : false;
  int get hashCode => id.hashCode;
}

class _Poll {
  final List<_Choice> choices;

  _Poll({@required this.choices});

  factory _Poll.fromJSON(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> jsonChoices = json['choices'];
    final choices =
        jsonChoices.map((choice) => _Choice.fromJSON(choice)).toList();
    return _Poll(choices: choices);
  }

  Map<String, dynamic> toJSON() => {'choices': choices};

  @override
  String toString() => json.encode(this);
}

class _Choice {
  final int id;
  final bool isVoted;
  final String text;
  final int votes;

  _Choice(
      {@required this.id,
      this.isVoted = false,
      @required this.text,
      @required this.votes});

  factory _Choice.fromJSON(Map<String, dynamic> json) => _Choice(
      id: json['id'],
      isVoted: json['isVoted'] ?? false,
      text: json['text'],
      votes: json['votes']);

  Map<String, dynamic> toJSON() =>
      {'id': id.toString(), 'isVoted': isVoted, 'text': text, 'votes': votes};

  @override
  String toString() => json.encode(this);
}

class _Geo {
  final List<int> coordinates;
  final int altitude;
  final int accuracy;
  final int altitudeAccuracy;
  final int heading;
  final int speed;

  _Geo({
    @required this.coordinates,
    @required this.altitude,
    @required this.accuracy,
    @required this.altitudeAccuracy,
    @required this.heading,
    @required this.speed,
  });

  _Geo.fromJSON(Map<String, dynamic> json)
      : coordinates = json['coordinates'],
        altitude = json['altitude'],
        accuracy = json['accuracy'],
        altitudeAccuracy = json['altitudeAccuracy'],
        heading = json['heading'],
        speed = json['speed'];

  Map<String, dynamic> toJSON() => {
        'coordinates': coordinates,
        'altitude': altitude,
        'accuracy': accuracy,
        'altitudeAccuracy': altitudeAccuracy,
        'heading': heading,
        'speed': speed
      };

  @override
  String toString() => json.encode(this);
}
