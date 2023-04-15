import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_api/enums.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/repositories/weather_repositores.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._weatherRepository) : super(HomeState());

  final WeatherRepository _weatherRepository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(HomeState(status: Status.loading));
    try {
      final WeatherModel = await _weatherRepository.getWeatherModel(city: city);
      emit(HomeState(
        status: Status.success,
        model: WeatherModel,
      ));
    } catch (error) {
      emit(HomeState(status: Status.error, errorMessage: error.toString()));
    }
  }
}
