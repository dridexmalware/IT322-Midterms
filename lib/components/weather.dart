import 'package:flutter/material.dart';
import 'weather_service.dart';  // Make sure to import your WeatherService class
import 'weather_model.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final _weatherService = WeatherService('67ef81405bc31a1a4266fcb992e64a2b');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  String getFishingSafetyMessage() {
    if (_weather != null && _weather!.windSpeed >= 39.0) {
      return "It's NOT SAFE for fishing!";
    } else {
      return "It's safe for fishing";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerMaxHeight = screenHeight * 0.5;

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxHeight: containerMaxHeight),
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: AspectRatio(
            aspectRatio: 360 / 184,  // Adjust this value as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/weatherbg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 20.0, 30.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weather?.temperature.round()}°',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Proxima Nova',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              getFishingSafetyMessage(),
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Proxima Nova',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Wind: ${_weather?.windSpeed.toStringAsFixed(1)} km/h',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Proxima Nova',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _weather?.cityName ?? "Loading city...",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Proxima Nova',
                                color: Color(0xFFFFAB19),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        child: Transform.scale(
                          scale: 1.2,
                          child: Image.asset('assets/images/cloudy.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
