import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 155, 207),
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
            image: const DecorationImage(
              image: AssetImage('zxzx.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), 
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/wasd.jpg'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Puri Pumjit',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '660710251',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 26, 24, 24),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Information Technology',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 26, 24, 24),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '"เขามันอินดี้ พี่มันอินเดีย"',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 15, 14, 14),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/733/733547.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 20),
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/733/733558.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.black, size: 40),
                        SizedBox(width: 8),
                        Text(
                          '081-275-7955',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
