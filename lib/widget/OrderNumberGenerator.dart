class OrderNumberGenerator {
  static int _currentOrderNumber = 1;

  static String generateOrderNumber() {
    String timestamp = DateTime.now().toString().replaceAll(RegExp(r'[^0-9]'), '');
    String orderNumber = '${timestamp}${_formatOrderNumber(_currentOrderNumber)}';
    _currentOrderNumber++;
    return orderNumber;
  }

  static String _formatOrderNumber(int number) {
    String formatted = number.toString().padLeft(5, '0'); // 控制位数
    return formatted;
  }
}
