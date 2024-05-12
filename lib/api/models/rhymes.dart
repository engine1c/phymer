import 'package:json_annotation/json_annotation.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhimes {
  const Rhimes({
    required this.words,
  });

  factory Rhimes.fromJson(Map<String, dynamic> json) => _$RhimesFromJson(json);

  final List<String> words;

  Map<String, dynamic> toJson() => _$RhimesToJson(this);
}
