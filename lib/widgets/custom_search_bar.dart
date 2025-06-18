import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? const Color(0xFF43D1BD) : const Color(0xFF283244);
    final backroundSearchColor = isDarkMode ? const Color(0xFF374156) : const Color(0xFF495369);
    final iconColor = isDarkMode ? const Color(0xFF43D1BD) : Colors.white;


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(left: 40, right: 20),
      decoration: BoxDecoration(
        color: backroundSearchColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
          left: BorderSide(color: borderColor, width: 1),
          right: BorderSide(color: borderColor, width: 1),
          bottom: BorderSide(color: borderColor, width: 4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: (_) => onSearch(),
                cursorColor: Colors.white, // màu con trỏ
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                  filled: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

          ),
          GestureDetector(
            onTap: onSearch,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: iconColor),
            ),
          ),
        ],
      ),
    );
  }
}
