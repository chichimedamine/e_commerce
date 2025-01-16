import 'package:hive_ce/hive.dart';

class Rating  extends HiveObject{
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
 
}