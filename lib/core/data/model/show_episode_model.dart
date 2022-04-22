import 'package:equatable/equatable.dart';

class ShowEpisodeModel extends Equatable {
  const ShowEpisodeModel({
    required this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.runtime,
    this.rating,
    this.mediumImage,
    this.originalImage,
    this.summary,
  });

  final int id;
  final String? url;
  final String? name;
  final int? season;
  final int? number;
  final String? type;
  final String? airdate;
  final String? airtime;
  final int? runtime;
  final double? rating;
  final String? mediumImage;
  final String? originalImage;
  final String? summary;

  factory ShowEpisodeModel.fromJson(Map<String, dynamic> json) =>
      ShowEpisodeModel(
        id: json['id'],
        url: json['url'],
        name: json['name'],
        season: json['season'],
        number: json['number'],
        type: json['type'],
        airdate: json['airdate'],
        airtime: json['airtime'],
        runtime: json['runtime'],
        rating: json['rating']['average']?.toDouble(),
        mediumImage: json['image'] != null ? json['image']['medium'] : null,
        originalImage: json['image'] != null ? json['image']['original'] : null,
        summary: json['summary'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    data['type'] = type;
    data['airdate'] = airdate;
    data['airtime'] = airtime;
    data['runtime'] = runtime;
    data['rating'] = {
      'average': rating,
    };
    data['image'] = {
      'medium': mediumImage,
      'original': originalImage,
    };
    data['summary'] = summary;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
