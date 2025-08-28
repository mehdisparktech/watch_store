class NotificationModel {
  final String? id;
  final String? title;
  final String? body;
  final String? type; // 'order', 'message', 'promotion', 'system'
  final String? actionType; // 'navigate', 'url', 'none'
  final String? actionValue;
  final Map<String, dynamic>? data;
  final bool? isRead;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.actionType,
    this.actionValue,
    this.data,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      type: json['type']?.toString(),
      actionType: json['action_type']?.toString(),
      actionValue: json['action_value']?.toString(),
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['is_read'],
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'action_type': actionType,
      'action_value': actionValue,
      'data': data,
      'is_read': isRead,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    String? actionType,
    String? actionValue,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      actionType: actionType ?? this.actionType,
      actionValue: actionValue ?? this.actionValue,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NotificationSettingsModel {
  final bool? pushNotifications;
  final bool? emailNotifications;
  final bool? orderUpdates;
  final bool? promotions;
  final bool? messages;
  final bool? systemUpdates;

  NotificationSettingsModel({
    this.pushNotifications,
    this.emailNotifications,
    this.orderUpdates,
    this.promotions,
    this.messages,
    this.systemUpdates,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      pushNotifications: json['push_notifications'],
      emailNotifications: json['email_notifications'],
      orderUpdates: json['order_updates'],
      promotions: json['promotions'],
      messages: json['messages'],
      systemUpdates: json['system_updates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'push_notifications': pushNotifications,
      'email_notifications': emailNotifications,
      'order_updates': orderUpdates,
      'promotions': promotions,
      'messages': messages,
      'system_updates': systemUpdates,
    };
  }

  NotificationSettingsModel copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? orderUpdates,
    bool? promotions,
    bool? messages,
    bool? systemUpdates,
  }) {
    return NotificationSettingsModel(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      orderUpdates: orderUpdates ?? this.orderUpdates,
      promotions: promotions ?? this.promotions,
      messages: messages ?? this.messages,
      systemUpdates: systemUpdates ?? this.systemUpdates,
    );
  }
}
