class ProfileModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final DateTime? dateOfBirth;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.dateOfBirth,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      profileImage: json['profile_image']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      country: json['country']?.toString(),
      zipCode: json['zip_code']?.toString(),
      dateOfBirth:
          json['date_of_birth'] != null
              ? DateTime.tryParse(json['date_of_birth'].toString())
              : null,
      gender: json['gender']?.toString(),
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(json['updated_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'address': address,
      'city': city,
      'country': country,
      'zip_code': zipCode,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    DateTime? dateOfBirth,
    String? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UpdateProfileRequestModel {
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final DateTime? dateOfBirth;
  final String? gender;

  UpdateProfileRequestModel({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.dateOfBirth,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (country != null) data['country'] = country;
    if (zipCode != null) data['zip_code'] = zipCode;
    if (dateOfBirth != null)
      data['date_of_birth'] = dateOfBirth!.toIso8601String();
    if (gender != null) data['gender'] = gender;
    return data;
  }
}
