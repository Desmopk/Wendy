import 'package:flutter/material.dart';
import 'package:_minimal_weather/services/weather_services.dart';
import 'package:lottie/lottie.dart';
import '../model/Weather_model.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherServices =WeatherService(apiKey: '3fb6b933a468f71a45108b8fcf579790');
  Weather ? _weather;
  fetchWeather() async
  {
    String cityName= await _weatherServices.getCurrentCity();
    try{
      final weather =await _weatherServices.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    }
    catch (e)
    {
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition)
  { if(mainCondition ==null)return 'assets/Flamingo.json';
    switch(mainCondition.toLowerCase())
        {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rainy.json';
      case 'thunderstorm':
        return 'assets/Thunder.json';
      case 'clear':
        return 'assets/Sunny.json';
      default :
        return 'assets/Sunny.json';


    }
  }
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/Amaze.jpeg'),fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "loading city...",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text('${_weather?.temperature.round()}''`C',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              Text(_weather?.mainCondition ??"Feels like...",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ],
          ),
        ),
      ),

    );
  }
}
