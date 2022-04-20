import 'package:equatable/equatable.dart';

class ShowModel extends Equatable {
  const ShowModel({
    required this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.rating,
    this.mediumImage,
    this.originalImage,
    this.scheduleTime,
    this.scheduleDays,
    this.summary,
  });

  final int id;
  final String? url;
  final String? name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final double? rating;
  final String? mediumImage;
  final String? originalImage;
  final String? scheduleTime;
  final List<String>? scheduleDays;
  final String? summary;

  factory ShowModel.fromJson(Map<String, dynamic> json) => ShowModel(
        id: json['id'],
        url: json['url'],
        name: json['name'],
        type: json['type'],
        language: json['language'],
        genres: json['genres'].cast<String>(),
        status: json['status'],
        runtime: json['runtime'],
        averageRuntime: json['averageRuntime'],
        premiered: json['premiered'],
        ended: json['ended'],
        officialSite: json['officialSite'],
        rating: json['rating']['average']?.toDouble(),
        mediumImage: json['image'] != null ? json['image']['medium'] : null,
        originalImage: json['image'] != null ? json['image']['original'] : null,
        scheduleTime: json['schedule']['time'],
        scheduleDays: (json['schedule']['days'] as List)
            .map((day) => day.toString())
            .toList(),
        summary: json['summary'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['language'] = language;
    data['genres'] = genres;
    data['status'] = status;
    data['runtime'] = runtime;
    data['averageRuntime'] = averageRuntime;
    data['premiered'] = premiered;
    data['ended'] = ended;
    data['officialSite'] = officialSite;
    data['rating'] = {
      'average': rating,
    };
    data['image'] = {
      'medium': mediumImage,
      'original': originalImage,
    };
    data['schedule'] = {
      'time': scheduleTime,
      'days': scheduleDays,
    };
    data['summary'] = summary;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
