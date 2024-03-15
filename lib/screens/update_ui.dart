import 'package:weather_app/services/weather.dart';

class UpdateUI {
  late Function onUpdateUI;

  late DateTime darkThemeStartTime;
  late DateTime darkThemeEndTime;

  String? weatherIcon;
  String? skyCondition;
  int? temperature;
  String? cityName;
  String? weatherMessage;
  String? themeData;

  void updateCity(weatherData) {
    skyCondition = weatherData['weather'][0]['description'];
    var condition = weatherData['weather'][0]['id'];
    weatherIcon = WeatherModel().getWeatherIcon(condition);
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    weatherMessage = WeatherModel().getMessage(temperature!);

    print(temperature);
    onUpdateUI();
  }
}
