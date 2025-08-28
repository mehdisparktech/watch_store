class UserModel {
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final String? password;
  final String? phone;
  final String? profileImage;
  final String? address;
  final String? status;
  final bool? verified;
  final String? countryCode;
  final String? enterprise;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserModel({
    this.id,
    this.name,
    this.role,
    this.email,
    this.password,
    this.phone,
    this.profileImage,
    this.address,
    this.status,
    this.verified,
    this.countryCode,
    this.enterprise,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString(),
      role: json['role']?.toString(),
      email: json['email']?.toString(),
      password: json['password']?.toString(),
      phone: json['phone']?.toString(),
      profileImage: json['profileImage']?.toString(),
      address: json['address']?.toString(),
      status: json['status']?.toString(),
      verified: json['verified'] as bool?,
      countryCode: json['countryCode']?.toString(),
      enterprise: json['enterprise']?.toString(),
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'].toString())
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'].toString())
              : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'role': role,
      'email': email,
      'password': password,
      'phone': phone,
      'profileImage': profileImage,
      'address': address,
      'status': status,
      'verified': verified,
      'countryCode': countryCode,
      'enterprise': enterprise,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? role,
    String? email,
    String? password,
    String? phone,
    String? profileImage,
    String? address,
    String? status,
    bool? verified,
    String? countryCode,
    String? enterprise,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      status: status ?? this.status,
      verified: verified ?? this.verified,
      countryCode: countryCode ?? this.countryCode,
      enterprise: enterprise ?? this.enterprise,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}
