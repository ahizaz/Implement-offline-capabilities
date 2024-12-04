class Item {
  final int id;
  final String name;

  Item({required this.id, required this.name});

  // Factory method to parse JSON from API response
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json['id'], name: json['name']);
  }

  // Convert an Item object into a map for SQLite storage
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  // Convert a map retrieved from SQLite into an Item object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(id: map['id'], name: map['name']);
  }
}