import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String username;

  // Category list with icons and colors
  final List<Map<String, dynamic>> categories = [
    {"name": "Science", "icon": Icons.science, "color": Colors.blue},
    {"name": "History", "icon": Icons.history, "color": Colors.brown},
    {"name": "Math", "icon": Icons.calculate, "color": Colors.purple},
    {"name": "Geography", "icon": Icons.public, "color": Colors.green},
    {"name": "Sports", "icon": Icons.sports_soccer, "color": Colors.orange},
    {"name": "Technology", "icon": Icons.computer, "color": Colors.teal},
    {"name": "Entertainment", "icon": Icons.movie, "color": Colors.red},
    {"name": "Literature", "icon": Icons.book, "color": Colors.indigo},
    {"name": "Music", "icon": Icons.music_note, "color": Colors.pink},
    {"name": "Art", "icon": Icons.brush, "color": Colors.amber},
  ];

  CategoryScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg2.jpg'), fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          title: Text(
            "Hello, @$username 👋",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                color: categories[index]["color"], // Unique color for each category
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(category: categories[index]["name"]),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        categories[index]["icon"],
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        categories[index]["name"],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
