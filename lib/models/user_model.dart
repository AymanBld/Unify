class UserModel {
  final String id;
  final String name;
  final String email;
  final int currentScore; // 0 to 100

  UserModel({required this.id, required this.name, required this.email, this.currentScore = 50});

  UserModel copyWith({String? id, String? name, String? email, int? currentScore}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      currentScore: currentScore ?? this.currentScore,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'currentScore': currentScore};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      currentScore: map['currentScore']?.toInt() ?? 50,
    );
  }
}
