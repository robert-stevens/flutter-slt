import 'package:flutter/material.dart';
class Utilitie{
  String id = UniqueKey().toString();
  String name;
  String image;
  String type;
  double price;
  int available;
  double rate;
  double discount;
  
  Utilitie(this.name, this.image,this.type,this.available, this.price, this.rate, this.discount);

  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return '\$${myPrice.toStringAsFixed(2)}';
    }
    return '\$${this.price.toStringAsFixed(2)}';
  }
}
class UtilitiesList {
  List<Utilitie> _popularList;
  List<Utilitie> _list;
  List<Utilitie> _recentList;
  List<Utilitie> _favoritesList;
  List<Utilitie> _cartList;

  //set recentList(List<Utilitie> value) {
    //_recentList = value;
  //}

  List<Utilitie> get recentList => _recentList;
  List<Utilitie> get list => _list;
  List<Utilitie> get popularList => _popularList;
  List<Utilitie> get favoritesList => _favoritesList;
  List<Utilitie> get cartList => _cartList;

  UtilitiesList() {
    _recentList =[
      Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
      Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60,  63, 5.0, 20.2),
      Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),
      Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
    ];
    
    _popularList = [
      Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
      Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
      Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),
      Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
      Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),

    ];

    _list = [
        Utilitie('Zogaa FlameSweater', 'img/man1.webp','Health & Fitness', 80, 2554, 3.1, 10.5),
        Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
        Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),

        Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
        Utilitie('Night Bar', 'img/coffebar1.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),
        Utilitie('Summer Coffee', 'img/coffebar4.jpeg', 'Health & Fitness',25,  130, 4.3, 12.1),
        Utilitie('Winter Coffee Bar', 'img/coffebar3.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),

        Utilitie('Sequins Party Dance Ballet Event', 'img/event2.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('Cenima film Event', 'img/event3.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),
        Utilitie('Creative Design Event', 'img/event1.jpeg','Business & Finance' ,80, 2554, 3.1, 10.5),

        Utilitie('BMW', 'img/car1.jpg','Coumputers & Technology', 80, 2554, 3.1, 10.5),
        Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        Utilitie('Car Repair', 'img/car2.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        Utilitie('Mechanical Cars', 'img/car4.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),

        Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25, 130, 4.3, 12.1),

        Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
        Utilitie('NBA Competions', 'img/sport2.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
        Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

        Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
        Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
        Utilitie('Paris', 'img/paris.jpg','Arts & Humanities', 35, 130, 6.3, 11.1), 
        Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
        Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60,  63, 5.0, 20.2),


    ];

    _favoritesList = [
      Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
      Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80, 2554, 3.1, 10.5),
      Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
      Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 200, 63, 5.0, 20.2),
      Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),

    ];

    _cartList = [
        Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60, 63, 5.0, 20.2),
        Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10, 415, 4.9, 15.3),
        Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 200, 63, 5.0, 20.2),
        Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80, 2554, 3.1, 10.5),


    ];
  }
}