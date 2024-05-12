// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhymes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rhimes _$RhimesFromJson(Map<String, dynamic> json) => Rhimes(
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RhimesToJson(Rhimes instance) => <String, dynamic>{
      'words': instance.words,
    };
