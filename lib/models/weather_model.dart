class WeatherModel {
  WeatherModel(
      {required this.city,
      required this.temperature,
      required this.country,
      required this.state,
      required this.wind,
      required this.localTime,
      required this.humidity,
      required this.feelslike,
      required this.precip});

  final double temperature;
  final String city;
  final String country;
  final String state;
  final double wind;
  final String localTime;
  final double humidity;
  final double feelslike;
  final double precip;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : city = json['location']['name'],
        temperature = json['current']['temp_c'] + 0.0,
        country = json['location']['country'],
        state = json['current']['condition']['text'],
        wind = json['current']['wind_kph'] + 0.0,
        localTime = json['location']['localtime'],
        humidity = json['current']['humidity'] + 0.0,
        feelslike = json['current']['feelslike_c'] + 0.0,
        precip = json['current']['precip_mm'] + 0.0;
}
