import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/forcast_card.dart';
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      const cityName = 'delhi';
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&APPID=$apiKey'));
      final data = jsonDecode(result.body);

      if (int.parse(data['cod']) != 200) {
        //error occured
        throw 'An unexpected error occured';
      }
      //return data['list'][0]['main']['temp'];
      return data;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          //snapshot - loading state, error state, data state
          //ConectionState.waiting, ConnectionState.done
          // print(snapshot);
          // print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              //adaptive for indicators as per the OS
              child: CircularProgressIndicator.adaptive(),
            );
          }

          //error checking
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final humidity = currentWeatherData['main']['humidity'].toString();
          final windSpeed = currentWeatherData['wind']['speed'].toString();
          final pressure = currentWeatherData['main']['pressure'].toString();

          IconData getCurrentSkyIcon(String currentSky) {
            if (currentSky == 'Clouds') {
              return Icons.cloud;
            }
            if (currentSky == 'Rain') {
              return Icons.cloudy_snowing;
            }
            return Icons.sunny;
          }

          final mainContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main Card
              SizedBox(
                width: double.infinity,
                child: Card(
                    elevation: 10,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp° C',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                getCurrentSkyIcon(currentSky),
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentSky,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hourly Forecast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              //Weather Cards
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       //for loop is fine - but it creates all the widgets on
              //       //the go - causing performance lags
              //       //better to use ListViewBuilder
              //       //for (int i = 1; i <= 5; i++)
              //         ForcastCard(
              //           time: data['list'][i]['dt'].toString(),
              //           forcastIcon: getCurrentSkyIcon(
              //               data['list'][i]['weather'][0]['main']),
              //           temp:
              //               '${data['list'][i]['main']['temp'].toString()}° C',
              //         ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyForecastData = data['list'][index + 1];
                      final time = DateTime.parse(hourlyForecastData['dt_txt']);
                      return ForcastCard(
                          time: DateFormat.j().format(time),
                          forcastIcon: getCurrentSkyIcon(
                              hourlyForecastData['weather'][0]['main']),
                          temp:
                              '${hourlyForecastData['main']['temp'].toString()}° C');
                    }),
              ),
              const SizedBox(
                height: 14,
              ),
              //Additonal Info
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoCard(
                    cardIcon: Icons.water_drop,
                    cardTitle: 'Humidity',
                    cardValue: humidity,
                  ),
                  AdditionalInfoCard(
                    cardIcon: Icons.air,
                    cardTitle: 'Wind Speed',
                    cardValue: windSpeed,
                  ),
                  AdditionalInfoCard(
                    cardIcon: Icons.beach_access,
                    cardTitle: 'Pressure',
                    cardValue: pressure,
                  ),
                ],
              )
            ],
          );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: screenSize.width > 1080
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 200),
                      child: mainContent,
                    )
                  : mainContent,
            ),
          );
        },
      ),
    );
  }
}
