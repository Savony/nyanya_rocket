import 'package:meta/meta.dart';
import 'package:nyanya_rocket/models/challenge_data.dart';

class NamedChallengeData {
  String name;
  ChallengeData challengeData;

  NamedChallengeData(
      {@required this.name,
      @required String gameData,
      @required ChallengeType type})
      : challengeData = ChallengeData(gameData: gameData, type: type);

  NamedChallengeData.fromChallengeData(
      {@required this.name, @required this.challengeData});

  static NamedChallengeData fromJson(Map<String, dynamic> json) {
    return NamedChallengeData.fromChallengeData(
        name: json['name'], challengeData: ChallengeData.fromJson(json));
  }

  Map<String, dynamic> toJson() =>
      {'name': name}..addAll(challengeData.toJson());
}
