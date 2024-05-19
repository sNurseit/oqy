class Review {
  final int? id;
  final int? courseId;
  final int? userId;
  final int? rating;
  final String? review;
  final String? fullName;
  final String? dispatchDate;

  Review({
     this.id,
     this.courseId,
     this.userId,
     this.rating,
     this.review,
     this.fullName,
     this.dispatchDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      courseId: json['courseId'] as int,
      userId: json['userId'] as int,
      rating: json['rating'] as int,
      review: json['review'] as String,
      fullName: json['fullName'] as String,
      dispatchDate: json['dispatchDate'] as String,
    );
  }
}