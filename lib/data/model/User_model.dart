class UserModel{
  String id;
  String name;
  String email;
  String phone;
  int birthdayYear;
  String country;
  String avatar_url;
  String language;
  String role;
  bool is_vip;
  bool vip_auto_renew;
  DateTime vip_expired_at;
  bool two_factor_enable;
  String status;
  DateTime create_at;
  DateTime update_at;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthdayYear,
    required this.country,
    required this.avatar_url,
    required this.language,
    required this.role,
    required this.is_vip,
    required this.vip_auto_renew,
    required this.vip_expired_at,
    required this.two_factor_enable,
    required this.status,
    required this.create_at,
    required this.update_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      birthdayYear: json['birthday_year'] ?? 0,
      country: json['country'] ?? '',
      avatar_url: json['avatar_url'] ?? '',
      language: json['language'] ?? '',
      role: json['role'] ?? '',
      is_vip: json['is_vip'] ?? false,
      vip_auto_renew: json['vip_auto_renew'] ?? false,
      vip_expired_at: json['vip_expired_at'] != null
          ? DateTime.parse(json['vip_expired_at'])
          : DateTime.now(),
      two_factor_enable: json['two_factor_enable'] ?? false,
      status: json['status'] ?? '',
      create_at: json['create_at'] != null
          ? DateTime.parse(json['create_at'])
          : DateTime.now(),
      update_at: json['update_at'] != null
          ? DateTime.parse(json['update_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthday_year': birthdayYear,
      'country': country,
      'avatar_url': avatar_url,
      'language': language,
      'role': role,
      'is_vip': is_vip,
      'vip_auto_renew': vip_auto_renew,
      'vip_expired_at': vip_expired_at.toIso8601String(),
      'two_factor_enable': two_factor_enable,
      'status': status,
      'create_at': create_at.toIso8601String(),
      'update_at': update_at.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? birthdayYear,
    String? country,
    String? avatar_url,
    String? language,
    String? role,
    bool? is_vip,
    bool? vip_auto_renew,
    DateTime? vip_expired_at,
    bool? two_factor_enable,
    String? status,
    DateTime? create_at,
    DateTime? update_at,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthdayYear: birthdayYear ?? this.birthdayYear,
      country: country ?? this.country,
      avatar_url: avatar_url ?? this.avatar_url,
      language: language ?? this.language,
      role: role ?? this.role,
      is_vip: is_vip ?? this.is_vip,
      vip_auto_renew: vip_auto_renew ?? this.vip_auto_renew,
      vip_expired_at: vip_expired_at ?? this.vip_expired_at,
      two_factor_enable: two_factor_enable ?? this.two_factor_enable,
      status: status ?? this.status,
      create_at: create_at ?? this.create_at,
      update_at: update_at ?? this.update_at,
    );
  }
}