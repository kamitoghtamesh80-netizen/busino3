class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? passwordHash;
  final int walletBalance;
  final int createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.passwordHash,
    this.walletBalance = 0,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'password_hash': passwordHash,
      'wallet_balance': walletBalance,
      'created_at': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      mobile: map['mobile'] as String,
      passwordHash: map['password_hash'] as String?,
      walletBalance: map['wallet_balance'] as int? ?? 0,
      createdAt: map['created_at'] as int,
    );
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? mobile,
    String? passwordHash,
    int? walletBalance,
    int? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      passwordHash: passwordHash ?? this.passwordHash,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}