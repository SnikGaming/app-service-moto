String calculateTimeDifference(DateTime inputTime) {
  DateTime currentTime = DateTime.now();

  // Tính số thời gian đã nhập so với thời gian hiện tại
  Duration difference = currentTime.difference(inputTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return 'Vừa xong';
  }
}
