
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/pages/place_detail_page.dart';

class PlacesPage extends StatelessWidget {
  final List placesData;
  final category;
  final bool appBar;
  const PlacesPage(
      {Key? key, required this.placesData, required this.appBar, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
    return Scaffold(
      appBar: (appBar == true)
          ? AppBar(
              backgroundColor: category['color'],
              centerTitle: true,
              title: appBar ? Text(category['name']) : Text(''),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlaceDetailPage(
                        placeItem: placesData[index],
                      ),
                    ));
                  },
                  leading: CircleAvatar(
                    minRadius: 16.r,
                    maxRadius: 24.r,
                    backgroundImage: NetworkImage(placesData[index].urlImage[0]),
                  ),
                  title: Text(
                    placesData[index].name as String,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
                  ),
                  subtitle: Text(
                    '${provider.categoryItem(placesData[index])['name']} - 4,0 km - 5 amigos',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  trailing: IconButton(onPressed: () {
                    provider.toggleFavorite(placesData[index]);
                  }, icon: Icon(placesData[index].isFavorite == true ? Icons.favorite : Icons.favorite_border)),
                  isThreeLine: true,
                );
              },
              padding: EdgeInsets.all(4.h),
              physics: ScrollPhysics(),
              itemCount: placesData.length,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
