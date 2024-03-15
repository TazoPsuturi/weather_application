import 'package:flutter/material.dart';
import 'package:weather_app/check_theme.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/screens/update_UI.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

DateTime dateTime = DateTime.now();

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late UpdateUI updateUI = UpdateUI();

  int currentHour = dateTime.hour;
  int currentMinute = dateTime.minute;

  @override
  void initState() {
    super.initState();
    updateUI = UpdateUI();
    updateUI.onUpdateUI = () {
      setState(() {});
    };
    updateUI.updateCity(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //'images/weather_walpaper.jpg' :
            image: AssetImage(checkTheme() ?? true
                ? 'images/sky_wallpaper_day.jpg'
                : 'images/sky_wallpaper_night.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.geLocationWeather();
                      updateUI.updateCity(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  Text(
                    '${updateUI.cityName}',
                    style: kButtonTextStyle,
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await weather.getCityName(typedName);
                        updateUI.updateCity(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${updateUI.temperature}°c',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '${updateUI.weatherIcon}',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        '${updateUI.skyCondition}',
                        style: kButtonTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15.0),
              //   child: Text(
              //     '${updateUI.weatherMessage} in ${updateUI.cityName}',
              //     textAlign: TextAlign.center,
              //     style: kMessageTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
