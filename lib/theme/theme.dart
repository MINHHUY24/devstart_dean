import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// Chủ đề giao diện tối (Dark Theme) được tuỳ chỉnh
final ThemeData myDarkTheme = ThemeData(
  /// Thiết lập độ sáng: giao diện tối
  brightness: Brightness.dark,

  /// Màu nền mặc định cho Scaffold
  scaffoldBackgroundColor: const Color(0xFF1B2231),


  /// Màu chính (primary) dùng cho các thành phần chủ đạo như nút, tiêu đề
  primaryColor: const Color(0xFF43D1BD),

  /// Cấu hình giao diện AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF283244), // Màu nền AppBar
    elevation: 0, // Không đổ bóng AppBar
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 16), // Kiểu chữ cho tiêu đề AppBar
    iconTheme: IconThemeData(color: Colors.white), // Màu biểu tượng trong AppBar
  ),


  /// Cấu hình giao diện cho Input (TextField, v.v.)
  inputDecorationTheme: InputDecorationTheme(
    filled: true, // Bật nền cho TextField
    fillColor: const Color(0xFF283244), // Màu nền của TextField
    hintStyle: const TextStyle(color: Colors.grey), // Màu chữ gợi ý (hint text)
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Khoảng cách bên trong TextField

    // Viền mặc định
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF43D1BD)),
    ),

    // Viền khi enabled (bình thường)
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF43D1BD)),
    ),

    // Viền khi được focus (được chọn)
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFF43D1BD),
        width: 2, // Dày hơn để nhấn mạnh
      ),
    ),
  ),

  /// Cấu hình kiểu chữ tổng thể
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Dùng cho nội dung chính
    bodyMedium: TextStyle(color: Color(0xFF74777F)), // Dùng cho nội dung phụ
    labelLarge: TextStyle(color: Colors.white), // Dùng cho label lớn (nút, v.v.)
  ),

  /// Cấu hình cho ElevatedButton (nút có độ nâng)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF43D1BD), // Màu nền nút
      foregroundColor: Colors.white, // Màu chữ hoặc biểu tượng trên nút
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bo góc nút
      ),
    ),
  ),

  /// Cấu hình cho thanh điều hướng dưới cùng (BottomNavigationBar)
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF283244), // Màu nền thanh điều hướng
    selectedItemColor: Color(0xFF43D1BD), // Màu của mục được chọn
    unselectedItemColor: Color(0xFF74777F), // Màu của các mục không được chọn
    type: BottomNavigationBarType.fixed, // Giữ nguyên số mục không bị thu nhỏ
  ),
);




/// Chủ đề giao diện sáng (Light Theme) được tuỳ chỉnh
final ThemeData myLightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: const Color(0xFFFFFFFF),

  primaryColor: const Color(0xFF00796B),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF5F5F5),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
    iconTheme: IconThemeData(color: Colors.black),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF0F0F0),
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF00796B)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF00796B)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF00796B), width: 2),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    labelLarge: TextStyle(color: Colors.black),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF00796B),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF5F5F5),
    selectedItemColor: Color(0xFF00796B),
    unselectedItemColor: Color(0xFF9E9E9E),
    type: BottomNavigationBarType.fixed,
  ),
);



class ThemeController extends GetxController {
  var isDarkMode = true.obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}