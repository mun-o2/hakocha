class DummyCount {
  late String exchangeCount;
  late String profilePageCount;
  DummyCount({this.exchangeCount = "", this.profilePageCount = ""});
}

final DummyCount1 = DummyCount(exchangeCount: "30", profilePageCount: "32");

final DummyCount2 = DummyCount(exchangeCount: "28", profilePageCount: "30");
