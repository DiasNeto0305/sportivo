import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/models/place_list.dart';
import 'package:sportivo/pages/place_detail_page.dart';

class BigCards extends StatelessWidget {

  final placeItem;
  const BigCards(
      {Key? key, required this.placeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceList>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            placeItem.urlImage[0],
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDetailPage(
                placeItem: placeItem
              ),
            ));
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Text(
            '12km',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.sports,
              size: 20,
            ),
            color: provider.categoryItem(placeItem.id)['color'],
          ),
          title: Text(
            placeItem.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
