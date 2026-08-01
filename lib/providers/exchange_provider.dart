import 'package:flutter/material.dart';
import 'package:hakocha/data/dummy_exchange_data.dart';
import 'package:hakocha/models/exchange.dart';
import 'package:hakocha/models/user_profile.dart';

class ExchangeProvider extends ChangeNotifier {
  // TODO: Firebase Firestoreからユーザー情報を取得するように差し替える
  ExchangeStep _currentStep = ExchangeStep.idle;
  UserProfile? _matchedUser;
  String _freeSpace = '';

  ExchangeStep get currentStep => _currentStep;
  UserProfile? get matchedUser => _matchedUser;
  String get freeSpace => _freeSpace;

  int get exchangeCount {
    if (_matchedUser == null) {
      return 0;
    }
    return _countPastExchangeWithMatchedUser() + 1;
  }

  void simulateMatch() {
    // TODO: 将来的にBluetooth / Nearby等から交換IDを取得してユーザー情報をマッチさせる
    matchUser(dummyExchangeUser);
  }

  void matchUser(UserProfile user) {
    _matchedUser = user;
    _currentStep = ExchangeStep.matched;
    notifyListeners();
  }

  void startWriting() {
    if (_matchedUser == null) {
      return;
    }
    _currentStep = ExchangeStep.writing;
    notifyListeners();
  }

  void updateFreeSpace(String value) {
    _freeSpace = value;
    notifyListeners();
  }

  void completeExchange() {
    if (_matchedUser == null || _freeSpace.trim().isEmpty) {
      return;
    }
    // TODO: Firebase Firestoreへ交換データを保存する
    _currentStep = ExchangeStep.completed;
    notifyListeners();
  }

  void resetExchange() {
    _currentStep = ExchangeStep.idle;
    _matchedUser = null;
    _freeSpace = '';
    notifyListeners();
  }

  int _countPastExchangeWithMatchedUser() {
    if (_matchedUser == null) {
      return 0;
    }

    return dummyExchanges.where((exchange) {
      final isCurrentToMatched =
          exchange.senderId == dummyCurrentUser.id &&
          exchange.receiverId == _matchedUser!.id;
      final isMatchedToCurrent =
          exchange.senderId == _matchedUser!.id &&
          exchange.receiverId == dummyCurrentUser.id;
      return isCurrentToMatched || isMatchedToCurrent;
    }).length;
  }
}
