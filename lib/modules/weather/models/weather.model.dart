class Weather {
  final String? stadiumId;
  final double? temp;
  final String? description;

  Weather({
    this.stadiumId,
    this.temp,
    this.description,
  });

  Weather.fromJson(Map json)
      : stadiumId = json['stadium_id'],
        temp = json['temp'],
        description = json['description'];
}
