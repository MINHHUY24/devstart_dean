import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCourse extends StatelessWidget {
  const CardCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
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
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Full-Stack Developer",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Khoảng cách giữa tiêu đề và phụ đề
                          Text(
                            "Học lập trình từ A-Z",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Center(
                      child: SizedBox(
                        width: 70,
                        height: 38,
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              print('Play pressed');
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Play',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
