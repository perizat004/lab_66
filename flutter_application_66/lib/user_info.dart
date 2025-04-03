import 'package:flutter/material.dart';

// UserInfoPage деген класс, StatelessWidget-тен туындайды.
class UserInfoPage extends StatelessWidget {
  final String name, email, phone, story;

  // Конструктор арқылы name, email, phone, және story мәндерін қабылдайды.
  UserInfoPage(
      {required this.name,
      required this.email,
      required this.phone,
      required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar бөлімінде қосымшаның атауы көрсетіледі.
      appBar: AppBar(title: Text('User Info')),
      body: Padding(
        // Контентке әрбір элементтің айналасында 16 пиксель бос орын қосылады.
        padding: EdgeInsets.all(16.0),
        child: Column(
          // Мазмұнды бағанмен орналастыру.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Мақсатты қолданушының аты, электронды пошта, телефоны және әңгімесі көрсетіледі.
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Story: $story'),
          ],
        ),
      ),
    );
  }
}
