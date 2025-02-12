class Wishlist {
  int? id;
  final String name;
  final DateTime dueDate;
  final double goalAmount;
  final bool isCompleted;
  final double currentAmount;
  final String? imageURL;

  Wishlist({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.goalAmount,
    required this.isCompleted,
    required this.currentAmount,
    this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate.toIso8601String(),
      'goalAmount': goalAmount,
      'isCompleted': isCompleted ? 1 : 0,
      'currentAmount': currentAmount,
      'imageURL': imageURL,
    };
  }

  factory Wishlist.fromJson(Map<String, dynamic> map) {
    return Wishlist(
      id: map['id'] as int,
      name: map['name'] as String,
      dueDate: DateTime.parse(map['dueDate']),
      goalAmount: map['goalAmount'] as double,
      isCompleted: map['isCompleted'] as bool,
      currentAmount: map['currentAmount'] as double,
      imageURL: map['imageURL'] as String ?? "",
    );
  }
}
