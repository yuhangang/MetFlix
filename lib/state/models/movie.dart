import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Movie {
  final bool adult;
  final String backdrop_path;
  final List<int> genre_ids;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final DateTime release_date;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;
  Movie({
    required this.adult,
    required this.backdrop_path,
    required this.genre_ids,
    required this.id,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    required this.release_date,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
  });

  Movie copyWith({
    bool? adult,
    String? backdrop_path,
    List<int>? genre_ids,
    int? id,
    String? original_language,
    String? original_title,
    String? overview,
    double? popularity,
    DateTime? release_date,
    String? title,
    bool? video,
    double? vote_average,
    int? vote_count,
  }) {
    return Movie(
      adult: adult ?? this.adult,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      genre_ids: genre_ids ?? this.genre_ids,
      id: id ?? this.id,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      release_date: release_date ?? this.release_date,
      title: title ?? this.title,
      video: video ?? this.video,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'backdrop_path': backdrop_path,
      'genre_ids': genre_ids,
      'id': id,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'release_date': release_date.toIso8601String(),
      'title': title,
      'video': video,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'],
      backdrop_path: map['backdrop_path'],
      genre_ids: List<int>.from(map['genre_ids']),
      id: map['id'],
      original_language: map['original_language'],
      original_title: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      release_date: DateFormat("yyyy-MM-dd").parse(map['release_date']),
      title: map['title'],
      video: map['video'],
      vote_average: map['vote_average'].runtimeType == double
          ? map['vote_average']
          : map['vote_average'].toDouble(),
      vote_count: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(Map<String, dynamic> source) => Movie.fromMap(source);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie && other.id == this.id;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
        backdrop_path.hashCode ^
        genre_ids.hashCode ^
        id.hashCode ^
        original_language.hashCode ^
        original_title.hashCode ^
        overview.hashCode ^
        popularity.hashCode ^
        release_date.hashCode ^
        title.hashCode ^
        video.hashCode ^
        vote_average.hashCode ^
        vote_count.hashCode;
  }
}
