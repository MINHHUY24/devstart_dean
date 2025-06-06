import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardLevelCourse extends StatelessWidget {
  const CardLevelCourse({super.key, required this.onPressed});

  final ValueChanged<Map<String, dynamic>> onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF374156),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              top: BorderSide(color: Colors.tealAccent, width: 1),
              left: BorderSide(color: Colors.tealAccent, width: 1),
              right: BorderSide(color: Colors.tealAccent, width: 1),
              bottom: BorderSide(color: Colors.tealAccent, width: 4),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Center(
                  child: Text(
                    "Level 1",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                onTap: (){
                  onPressed({
                    'course': "Full-Stack Developer",
                    'level': 1,
                    'language': "Việt Nam",
                    'topic': "Design Partern"
                  });
                },
              )
            ],
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF374156),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              top: BorderSide(color: Colors.tealAccent, width: 1),
              left: BorderSide(color: Colors.tealAccent, width: 1),
              right: BorderSide(color: Colors.tealAccent, width: 1),
              bottom: BorderSide(color: Colors.tealAccent, width: 4),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Level 1",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
