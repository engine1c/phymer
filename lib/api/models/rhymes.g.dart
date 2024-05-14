// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhymes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rhymes _$RhimesFromJson(Map<String, dynamic> json) => Rhymes(
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RhimesToJson(Rhymes instance) => <String, dynamic>{
      'words': instance.words,
    };
