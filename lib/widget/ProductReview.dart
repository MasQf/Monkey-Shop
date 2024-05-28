import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductReview extends StatefulWidget {
  final double averageStars;
  final List reviews;

  ProductReview({required this.averageStars, required this.reviews});

  @override
  _ProductReviewState createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 商品平均星级
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(
                'Average Stars : ' + widget.averageStars.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.averageStars.floor(); i++)
                    Icon(
                      Icons.star_rate_rounded,
                      color: Color.fromARGB(255, 255, 218, 106),
                      size: 28,
                    ),
                  if (widget.averageStars > widget.averageStars.floor())
                    Icon(
                      Icons.star_half_rounded,
                      color: Color.fromARGB(255, 255, 218, 106),
                      size: 28,
                    ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 30),
        // 评论列表
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户名和星级
                Row(
                  children: [
                    Text(
                      widget.reviews[index].username,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Row(
                      //根据第一个参数这个数量,生成对应数量的内容
                      children: List.generate(
                        widget.reviews[index].stars,
                        (index) => Icon(Icons.star, color: Colors.amber, size: 16),
                      ),
                    ),
                  ],
                ),
                // 评论内容
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.reviews[index].comment,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
