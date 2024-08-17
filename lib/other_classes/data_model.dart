class WaterIntakeInfo {
  final DateTime timeInfo;
  final int glassesCount;

  WaterIntakeInfo({required this.glassesCount, required this.timeInfo});

  Map<String, dynamic> toMap() {
    return {'timeInfo': timeInfo.toString(), 'glassesCount': glassesCount};
  }
}
