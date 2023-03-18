class UserModule {
  final String email;
  final String? password;
  final int? year;
  final String? phone;
  final String? image;
  UserModule(
      {required this.email, this.image, this.password, this.phone, this.year});
}
