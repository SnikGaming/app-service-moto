String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Vui lòng nhập số điện thoại';
  }
  // Kiểm tra độ dài số điện thoại
  if (value.length != 10) {
    return 'Số điện thoại phải có 10 chữ số';
  }
  // Kiểm tra định dạng số điện thoại
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Số điện thoại chỉ chấp nhận các chữ số từ 0-9';
  }
  // Kiểm tra số điện thoại thuộc Việt Nam
  if (!value.startsWith('0')) {
    return 'Số điện thoại phải bắt đầu bằng số 0';
  }
  // Thêm các kiểm tra khác tùy theo yêu cầu cụ thể của bạn

  return null; // Trả về null nếu không có lỗi
}

// Sử dụng CustomTextField

