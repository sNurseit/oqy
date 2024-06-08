class Role {
  final int id;
  final String name;

  Role(this.id, this.name);

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      json['id'],
      json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
