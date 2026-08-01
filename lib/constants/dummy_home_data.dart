// lib/constants/dummy_home_data.dart
import '../dummy/dummy_profile.dart';
import '../dummy/dummy_profile2.dart';
import '../dummy/dummy_notifications.dart';
import '../dummy/dummy_Count.dart';

class DummyHomeData {
  String userName;
  String exchangeCount;
  String profilePageCount;
  String notification1;
  String notification2;

  DummyHomeData({
    this.userName = "",
    this.exchangeCount = "",
    this.profilePageCount = "",
    this.notification1 = "",
    this.notification2 = "",
  });
}

final DummyHomeData1 = DummyHomeData(
  userName: dummyProfile.name,
  exchangeCount: DummyCount1.exchangeCount,
  profilePageCount: DummyCount1.profilePageCount,
  notification1: DummyNotifications1.notification1,
  notification2: DummyNotifications1.notification2,
);

final DummyHomeData2 = DummyHomeData(
  userName: dummyProfile2.name,
  exchangeCount: DummyCount2.exchangeCount,
  profilePageCount: DummyCount2.profilePageCount,
  notification1: DummyNotifications2.notification1,
  notification2: DummyNotifications2.notification2,
);
