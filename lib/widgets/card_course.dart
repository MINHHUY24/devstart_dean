import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCourse extends StatelessWidget {
  const CardCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      'https://vtiacademy.edu.vn/upload/images/anh-link/muc-luong-full-stack-developer.png',
                      height: 110,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
