import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/forcast_card.dart';
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double? temp;
  Future getCurrentWeather() async {
    try {
      const cityName = 'delhi';
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&APPID=$apiKey'));
      final data = jsonDecode(result.body);

      // if (int.parse(data['cod']) != 200) {
      //   //error occured
      //   throw 'An unexpected error occured';
      // }

      setState(() {
        temp = data['list'][0]['main']['temp'];
      });
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: temp == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                                      '$temp° C',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Icon(
                                      Icons.cloud,
                                      size: 64,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Rain',
                                      style: TextStyle(
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
                      'Weather Forecast',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    //Weather Cards
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ForcastCard(
                            time: '3:00',
                            forcastIcon: Icons.cloud,
                            temp: '300.67° K',
                          ),
                          ForcastCard(
                            time: '3:00',
                            forcastIcon: Icons.cloud,
                            temp: '300.67° K',
                          ),
                          ForcastCard(
                            time: '3:00',
                            forcastIcon: Icons.cloud,
                            temp: '300.67° K',
                          ),
                          ForcastCard(
                            time: '3:00',
                            forcastIcon: Icons.cloud,
                            temp: '300.67° K',
                          ),
                        ],
                      ),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoCard(
                          cardIcon: Icons.water_drop,
                          cardTitle: 'Humidity',
                          cardValue: '94',
                        ),
                        AdditionalInfoCard(
                          cardIcon: Icons.air,
                          cardTitle: 'Wind Speed',
                          cardValue: '7.67',
                        ),
                        AdditionalInfoCard(
                          cardIcon: Icons.beach_access,
                          cardTitle: 'Pressure',
                          cardValue: '1006',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
