import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteCards extends StatelessWidget {
  final favoriteItem;

  const FavoriteCards({Key? key, required this.favoriteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        width: deviceSize.width * 0.82,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        height: 150.h,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 2,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  favoriteItem.urlImage[0],
                  fit: BoxFit.cover,
                  width: deviceSize.width * 0.30,
                  height: 150,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favoriteItem.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      favoriteItem.address,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
