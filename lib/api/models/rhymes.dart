import 'package:json_annotation/json_annotation.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhymes {
  const Rhymes({
    required this.words,
  });

  factory Rhymes.fromJson(Map<String, dynamic> json) => _$RhimesFromJson(json);

  final List<String> words;

  Map<String, dynamic> toJson() => _$RhimesToJson(this);
}
