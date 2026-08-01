class ProfileData {
  String instagramId;
  String xId;

  String name;

  String birthYear;
  String birthMonth;
  String birthDay;

  String zodiacSign;
  String bloodType;
  String mbti;
  String nickname;
  String personality;
  String holidayLife;

  String birthplace;
  String brothers;
  String height;
  String shoeSize;

  String idealType;

  String ifMagicWish;
  String ifNextLife;

  String freeSpace;

  YesNoAnswer confessed;
  YesNoAnswer beenConfessed;
  YesNoAnswer hasCrush;

  WhichOneAnswer dogOrCat;
  WhichOneAnswer indoorOrOutdoor;
  WhichOneAnswer thrill;
  WhichOneAnswer kinokoOrTakenoko;
  WhichOneAnswer reply;

  ProfileData({
    this.instagramId = "",
    this.xId = "",

    this.name = "",

    this.birthYear = "",
    this.birthMonth = "",
    this.birthDay = "",

    this.zodiacSign = "",
    this.bloodType = "",
    this.mbti = "",
    this.nickname = "",
    this.personality = "",
    this.holidayLife = "",

    this.birthplace = "",
    this.brothers = "",
    this.height = "",
    this.shoeSize = "",

    this.idealType = "",

    this.ifMagicWish = "",
    this.ifNextLife = "",

    this.freeSpace = "",

    this.confessed = YesNoAnswer.unknown,
    this.beenConfessed = YesNoAnswer.unknown,
    this.hasCrush = YesNoAnswer.unknown,

    this.dogOrCat = WhichOneAnswer.unknown,
    this.indoorOrOutdoor = WhichOneAnswer.unknown,
    this.thrill = WhichOneAnswer.unknown,
    this.kinokoOrTakenoko = WhichOneAnswer.unknown,
    this.reply = WhichOneAnswer.unknown,
  });
}

enum YesNoAnswer { yes, no, unknown }

enum WhichOneAnswer { left, center, right, unknown }
