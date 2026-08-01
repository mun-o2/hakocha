class Exchange {
  final String id;
  final String senderId;
  final String receiverId;
  final String freeSpace;
  final DateTime exchangedAt;

  const Exchange({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.freeSpace,
    required this.exchangedAt,
  });
}

enum ExchangeStep { idle, matched, writing, completed }
