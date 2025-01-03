class Wishlist {
  final int id;
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
}
