class Weather {
  final String? stadiumId;
  final double? temp;
  final String? description;
  final String? icon;

  Weather({
    this.stadiumId,
    this.temp,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map json)
      : stadiumId = json['stadium_id'],
        temp = json['temp'],
        description = json['description'],
        icon = json['icon'];
}
