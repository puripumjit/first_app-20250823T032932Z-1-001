import 'package:flutter/material.dart';
import 'ProfileCard.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 119, 119),
      body: const Center(
        child: ProfileCard(
          name: 'Puri Pumjit',
          position: 'Programer',
          email: 'pumjit_p@su.ac.th',
          phoneNumber: '081-275-7955',
          imageUrl: 'https://picsum.photos/id/1025/200/200',
        ),
      ),
    );
  }
}
