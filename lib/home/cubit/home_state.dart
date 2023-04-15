part of 'home_cubit.dart';

class HomeState {
  HomeState({this.model, this.errorMessage, this.status = Status.initial});

  final WeatherModel? model;
  final String? errorMessage;
  final Status status;
}
