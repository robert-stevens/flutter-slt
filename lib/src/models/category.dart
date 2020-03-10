import 'package:listing/config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:listing/src/models/utilities.dart';

class Category {

  String id = UniqueKey().toString();
  String name;
  bool selected;
  IconData icon;
  Color color;
  List<Utilitie> utilities;
  
  Category(this.name, this.icon, this.selected,this.color, this.utilities);
}

class SubCategory {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  List<Utilitie> utilities;

  SubCategory(this.name, this.selected, this.utilities);
}

class CategoriesList {
  List<Category> _list;

  List<Category> get list => _list;

  CategoriesList() {

    this._list = [
      Category('GCSE PE', UiIcons.sport, false, Colors.greenAccent,[
        Utilitie('Zogaa FlameSweater', 'img/mall1.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
        Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
        Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),

      ]),
      Category('A Level PE', UiIcons.sport, true,  Colors.cyan, [
        Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
        Utilitie('Night Bar', 'img/coffeebar1.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),
        Utilitie('Summer Coffee', 'img/coffeebar3.jpeg', 'Health & Fitness',25,  130, 4.3, 12.1),
        Utilitie('Winter Coffee Bar', 'img/coffeebar4.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),

      ]),
      Category('Vocational PE L2', UiIcons.sport, false, Colors.blueAccent, [
        Utilitie('Sequins Party Dance Ballet Event', 'img/event2.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('Cenima film Event', 'img/event3.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('TomorrowLand Event', 'img/event4.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),
        Utilitie('Creative Design Event', 'img/event1.jpg','Business & Finance' ,80,  2554, 3.1, 10.5),

      ]),
      Category('Vocational PE L3', UiIcons.sport, false, Colors.blueAccent, [
        Utilitie('Sequins Party Dance Ballet Event', 'img/event2.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('Cenima film Event', 'img/event3.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        Utilitie('TomorrowLand Event', 'img/event4.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),
        Utilitie('Creative Design Event', 'img/event1.jpg','Business & Finance' ,80,  2554, 3.1, 10.5),

      ]),
      Category('Core PE', UiIcons.sport, false, Colors.orange, [
        Utilitie('WebSite Design ', 'img/jobs2.jpg','Business & Finance', 80, 2554, 3.1, 10.5),
        Utilitie('House Keeper', 'img/jobs3.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

        
      ]),
      Category('Other', UiIcons.sport, false,  Colors.pinkAccent, [
        Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
        Utilitie('Piano Piano Food', 'img/restaurent.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),

      ]),
      // Category('Automotive', UiIcons.car_1, false,  Colors.deepPurpleAccent,[
      //   Utilitie('BMW', 'img/car1.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),
      //   Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      //   Utilitie('Car Repair', 'img/car2.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
      //   Utilitie('Mechanical Cars', 'img/car4.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),
        
      // ]),
      // Category('Sport', UiIcons.sport, false,  Colors.brown,[
      //   Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
      //   Utilitie('NBA Competions', 'img/sport2.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
      //   Utilitie('Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

       
      // ]),
      // Category('Travel', UiIcons.tent, true, Colors.redAccent,[
      //   Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
      //   Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
      //   Utilitie('Paris', 'img/paris.jpg','Arts & Humanities', 35,  130, 6.3, 11.1), 
      //   Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
      //   Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology',  200, 63, 5.0, 20.2),


      // ]),
    ];
  }

  selectById(String id) {
    _list.forEach((Category category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}

class SubCategoriesList {
  List<SubCategory> _list;

  List<SubCategory> get list => _list;

  /*SubCategoriesList() {
    this._list = [
      SubCategory('Arts & Humanities', true, [
        Utilitie('Zogaa FlameSweater', 'img/man1.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Men Polo Shirt Brand Clothing', 'img/man2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Polo Shirt for Men', 'img/man3.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Men\'s Sport Pants Long Summer', 'img/man4.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Men\'s Hoodies Pullovers Striped', 'img/man5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Men Double Breasted Suit Vests', 'img/man6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Puimentiua Summer Fashion', 'img/man7.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Casual Sweater fashion Jacket', 'img/man8.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      SubCategory('Health & Fitness', true, [
        Utilitie('Summer Fashion Women Dress', 'img/pro5.webp', 'Arts & Humanities',25, 19.64, 200, 130, 4.3, 12.1),
        Utilitie('Women Half Sleeve', 'img/pro6.webp','Arts & Humanities', 60, 94.36, 200, 42, 5.0, 20.2),
        Utilitie('Elegant Plaid Dresses Women Fashion', 'img/pro7.webp', 'Arts & Humanities',10, 15.73, 200, 415, 4.9, 15.3),
        Utilitie('Maxi Dress For Women Summer', 'img/pro1.webp','Arts & Humanities', 25, 19.64, 200, 130, 4.3, 12.1),
        Utilitie('Black Checked Retro Hepburn Style', 'img/pro2.webp', 'Arts & Humanities',60, 94.36, 200, 63, 5.0, 20.2),
        Utilitie('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 'Arts & Humanities',10, 15.73, 200, 415, 4.9, 15.3),
        Utilitie('Elegant Casual Dress', 'img/pro4.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      SubCategory('Business & Finance', true, [
        Utilitie('Fashion Baby Sequins Party Dance Ballet', 'img/baby1.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Children Martin Boots PU Leather', 'img/baby2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Baby Boys Denim Jacket', 'img/baby3.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Mom and Daughter Matching Women', 'img/baby4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Unicorn Pajamas Winter Flannel Family', 'img/baby5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Party Decorations Kids', 'img/baby6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      SubCategory('Coumputers & Technology', true, [
        Utilitie('Yosoo Knee pad Elastic', 'img/sport4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Spring Hand Grip Finger Strength', 'img/sport5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Knee Sleeves', 'img/sport6.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Brothock Professional basketball socks', 'img/sport7.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('New men s running trousers', 'img/sport8.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Spring Half Finger Outdoor Sports', 'img/sport10.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      SubCategory('Leisure & Tavel', true, [
        Utilitie('Cooking Tools Set Premium', 'img/home1.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Reusable Metal Drinking Straws', 'img/home2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Absorbent Towel Face', 'img/home3.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Pair Heat Resistant Thick Silicone', 'img/home4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Electric Mosquito Killer Lamp', 'img/home5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Terrarium Hydroponic Plant Vases', 'img/home6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        Utilitie('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
    ];
  }*/

  selectById(String id) {
    this._list.forEach((SubCategory subCategory) {
      subCategory.selected = false;
      if (subCategory.id == id) {
        subCategory.selected = true;
      }
    });
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}
