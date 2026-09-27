class UserSetting {
  final bool downloadOnlyWifi;
  final bool notificationEnabled;
  final Map<String, dynamic> equalizerPreset;

  UserSetting({
    required this.downloadOnlyWifi,
    required this.notificationEnabled,
    required this.equalizerPreset,
  });

  factory UserSetting.fromJson(Map<String, dynamic> json) {
    return UserSetting(
      downloadOnlyWifi: json['downloadOnlyWifi'] as bool? ?? false,
      notificationEnabled: json['notificationEnabled'] as bool? ?? false,
      equalizerPreset: json['equalizerPreset'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'download_only_wifi': downloadOnlyWifi,
      'notification_enabled': notificationEnabled,
      'equalizer_preset': equalizerPreset,
    };
  }

  UserSetting copyWith({
    bool? downloadOnlyWifi,
    bool? notificationEnabled,
    Map<String, dynamic>? equalizerPreset,
  }) {
    return UserSetting(
      downloadOnlyWifi: downloadOnlyWifi ?? this.downloadOnlyWifi,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      equalizerPreset: equalizerPreset ?? this.equalizerPreset,
    );
  }
}
