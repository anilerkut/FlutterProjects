import 'package:flutter_lifetime_app/user_data.dart';

class Calculation {
  UserData user;

  Calculation(this.user);

  double calculation() {
    double expectedLife;
    expectedLife = 90 + user.exercise - (user.cigarette / 2);
    expectedLife = expectedLife + (user.height / user.weight);

    if (user.cinsiyet == "female") {
      return expectedLife += 3;
    } else {
      return expectedLife;
    }
  }
}
