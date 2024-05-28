// 商品model
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final List<Review> reviews;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.reviews,
    this.isFavorite = false,
  });

  // 无参数构造函数
  Product.empty()
      : id = '',
        name = '',
        price = 0.0,
        description = '',
        images = [],
        reviews = [],
        isFavorite = false;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      images: List<String>.from(map['images']),
      reviews: (map['reviews'] as List).map((e) => Review.fromMap(e)).toList(),
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'reviews': reviews.map((e) => e.toMap()).toList(),
      'isFavorite': isFavorite,
    };
  }
}

// 商品评论model
class Review {
  final String username;
  final String comment;
  final int stars;

  Review({
    required this.username,
    required this.comment,
    required this.stars,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      username: map['username'],
      comment: map['comment'],
      stars: map['stars'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'comment': comment,
      'stars': stars,
    };
  }
}
