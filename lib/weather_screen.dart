import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/forcast_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: SingleChildScrollView(
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
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '300.67° K',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                Icons.cloud,
                                size: 64,
                              ),
                              SizedBox(height: 16),
                              Text(
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
                    ForcastCard(),
                    ForcastCard(),
                    ForcastCard(),
                    ForcastCard(),
                    ForcastCard(),
                    ForcastCard(),
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
                height: 20,
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
