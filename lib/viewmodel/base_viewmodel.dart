import 'package:flutter/material.dart';
import 'package:flutter_mvvm/enums/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  String _errorMessage = '';

  //getter
  ViewState get state => _state;

  String get errorMessage => _errorMessage;

  //setters
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
