class Slider {
  String image;
  Slider({this.image,});
}

class SliderList {
  List<Slider> _list;

  List<Slider> get list => _list;

  SliderList() {
    _list = [
      new Slider(image:'img/slider3.jpg'),
      new Slider(image:'img/slider1.png'),
      new Slider(image:'img/slider2.jpg'),
    ];
  }
}
