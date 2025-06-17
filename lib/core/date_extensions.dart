extension DateExtensions on DateTime{

  String formatTime() {
    final now = DateTime.now();
    if (now.difference(this).inDays == 0) {
      return '$hour:${minute.toString().padLeft(2, '0')}';
    } else if (now.difference(this).inDays == 1) {
      return 'Yesterday';
    } else {
      return '$day/$month';
    }
  }

}