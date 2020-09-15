class MembershipOption {
  String level;
  String title;
  String subTitle;
  double price;
  List<String> benefits;

  MembershipOption(
      {this.level, this.title, this.subTitle, this.price, this.benefits});
}

class MembershipOptionList {
  List<MembershipOption> _list;

  List<MembershipOption> get list => _list;

  MembershipOptionList() {
    _list = [
      new MembershipOption(
          level: '2',
          title: '1 USER BUNDLE',
          subTitle: '£19.99 A Year - 1 Users (SINGLE USER)',
          price: 19.99,
          benefits: [
            "FULL ACCESS OF SITE",
            "PREMIUM RESOURCES",
            "E LEARNING VIDEOS",
            "CREATE AND MANAGE GROUPS",
            "ASK THE PE-OPLE",
            "NEWSLETTER",
            "LIVE CHAT",
            "JOB BULLETIN",
            "SHARE & TAG RESOURCES",
          ]),
      new MembershipOption(
          level: '4',
          title: '5 USER BUNDLE',
          subTitle: '£89.99 A Year - 5 Users (DEPARTMENT USE)',
          price: 89.99,
          benefits: [
            "FULL ACCESS OF SITE",
            "PREMIUM RESOURCES",
            "E LEARNING VIDEOS",
            "CREATE AND MANAGE GROUPS",
            "ASK THE PE-OPLE",
            "NEWSLETTER",
            "LIVE CHAT",
            "JOB BULLETIN",
            "SHARE & TAG RESOURCES",
          ]),
      new MembershipOption(
          level: '5',
          title: '10 USER BUNDLE',
          subTitle: '£179.99 A Year - 10 Users (DEPARTMENT USE)',
          price: 179.99,
          benefits: [
            "FULL ACCESS OF SITE",
            "PREMIUM RESOURCES",
            "E LEARNING VIDEOS",
            "CREATE AND MANAGE GROUPS",
            "ASK THE PE-OPLE",
            "NEWSLETTER",
            "LIVE CHAT",
            "JOB BULLETIN",
            "SHARE & TAG RESOURCES",
          ]),
      new MembershipOption(
          level: '6',
          title: '15 USER BUNDLE',
          subTitle: '£269.99 A Year - 15 Users (DEPARTMENT USE)',
          price: 269.99,
          benefits: [
            "FULL ACCESS OF SITE",
            "PREMIUM RESOURCES",
            "E LEARNING VIDEOS",
            "CREATE AND MANAGE GROUPS",
            "ASK THE PE-OPLE",
            "NEWSLETTER",
            "LIVE CHAT",
            "JOB BULLETIN",
            "SHARE & TAG RESOURCES",
          ]),
    ];
  }
}
