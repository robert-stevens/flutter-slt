class OnBoarding {
  String image;
  String description;

  OnBoarding({this.image, this.description});
}

class OnBoardingList {
  List<OnBoarding> _list;

  List<OnBoarding> get list => _list;

  OnBoardingList() {
    _list = [
      new OnBoarding(image: 'img/onboarding1.png', description: 'Discover your location in detail pick up information and enjoy.'),
      new OnBoarding(image: 'img/onboarding2.png', description: 'Easily find your category with felixible display support.'),
      //new OnBoarding(image: 'images/onboarding1.png', description: 'So many books, so little time.'),
      //new OnBoarding(image: 'images/onboarding2.png', description: 'A room without books is like a body without a soul.'),
    ];
  }
}
