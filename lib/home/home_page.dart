import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api/data/weather_remote_data.dart';
import 'package:weather_api/enums.dart';
import 'package:weather_api/home/cubit/home_cubit.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/repositories/weather_repositores.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        WeatherRepository(WeatherRemoteDataSource()),
      ),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errroMessage = state.errorMessage ?? 'Error';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errroMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          final weatherModel = state.model;
          return Scaffold(
            backgroundColor: const Color(0xff22262b),
            body: Center(
              child: Builder(builder: (context) {
                if (state.status == Status.loading) {
                  return const Text('Loading');
                }
                return Column(
                  children: [
                    CitySearch(),
                    if (weatherModel != null)
                      DisplayWheather(
                        weatherModel: weatherModel,
                      )
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class CitySearch extends StatelessWidget {
  CitySearch({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                hintText: 'London',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context
                    .read<HomeCubit>()
                    .getWeatherModel(city: controller.text);
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

class DisplayWheather extends StatelessWidget {
  const DisplayWheather({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Text(
                weatherModel.localTime,
                style: const TextStyle(fontSize: 13, color: Colors.white30),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    '${weatherModel.city}, ',
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    weatherModel.country,
                    style: const TextStyle(fontSize: 15, color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${weatherModel.temperature.toStringAsFixed(0)}℃',
                    style: const TextStyle(fontSize: 70, color: Colors.white),
                  ),
                  const Image(
                    image: AssetImage('images/moon.png'),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                width: 370,
                decoration: BoxDecoration(
                  color: const Color(0xff323741),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '💨',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${weatherModel.wind.toString()} km/h',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.white30,
                            width: 1,
                            thickness: 1,
                          ),
                          Column(
                            children: [
                              const Text(
                                '☔',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${weatherModel.humidity.toString()} %',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.white30,
                            width: 1,
                            thickness: 1,
                          ),
                          Column(
                            children: [
                              const Text(
                                '💦',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${weatherModel.precip.toString()} mm',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.white30,
                            width: 1,
                            thickness: 1,
                          ),
                          Column(
                            children: [
                              const Text(
                                '🌡️',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${weatherModel.feelslike.toString()}℃',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
