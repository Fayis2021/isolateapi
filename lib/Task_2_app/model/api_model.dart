class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String ipAddress;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.ipAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      ipAddress: json['ip_address'],
    );
  }
}