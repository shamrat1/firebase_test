class ChatUser {
  ChatUser({
    this.image,
    this.about,
    this.name,
    this.createdAt,
    this.isOnline,
    this.id,
    this.lastActive,
    this.email,
    this.phone,
    this.pushToken,
  });
  String? image;
  String? about;
  String? name;
  String? createdAt;
  bool? isOnline;
  String? id;
  String? lastActive;
  String? email;
  String? phone;
  String? pushToken;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  ChatUser.fromMap(Map<String, dynamic> map) {
    image = map['image'] ?? '';
    about = map['about'] ?? '';
    name = map['name'] ?? '';
    createdAt = map['created_at'] ?? '';
    isOnline = map['is_online'] ?? false;
    id = map['id'] ?? '';
    lastActive = map['last_active'] ?? '';
    email = map['email'] ?? '';
    phone = map['phone'] ?? '';
    pushToken = map['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['phone'] = phone;
    data['push_token'] = pushToken;
    return data;
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['phone'] = phone;
    data['push_token'] = pushToken;
    return data;
  }
}
