import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  const PersonModel({
    required this.id,
    this.name,
    this.country,
    this.birthday,
    this.deathday,
    this.gender,
    this.mediumImage,
    this.originalImage,
  });

  final int id;
  final String? name;
  final String? country;
  final String? birthday;
  final String? deathday;
  final String? gender;
  final String? mediumImage;
  final String? originalImage;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json['id'],
        name: json['name'],
        country: json['country'] != null ? json['country']['name'] : null,
        birthday: json['birthday'],
        deathday: json['deathday'],
        gender: json['gender'],
        mediumImage: json['image'] != null ? json['image']['medium'] : null,
        originalImage: json['image'] != null ? json['image']['original'] : null,
      );

  @override
  List<Object?> get props => [
        id,
      ];
}
