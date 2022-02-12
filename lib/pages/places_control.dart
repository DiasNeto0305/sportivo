import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/models/place_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacesControl extends StatefulWidget {
  const PlacesControl({Key? key}) : super(key: key);

  @override
  _PlacesControlState createState() => _PlacesControlState();
}

class _PlacesControlState extends State<PlacesControl> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Locais'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/place-form");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: provider.placesItemsCount,
        itemBuilder: (ctx, index) {
          return ListTile(
            onTap: () {},
            leading: CircleAvatar(
                minRadius: 16.r,
                maxRadius: 24.r,
                backgroundImage:
                    NetworkImage(provider.places[index].urlImage[0])),
            title: Text(
              provider.places[index].name as String,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            subtitle: Text('Teste'),
            trailing: Container(
              width: 105.w,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/place-form',
                          arguments: provider.places[index]);
                    },
                    icon: Icon(Icons.edit),
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    onPressed: () {
                      provider.removePlace(provider.places[index]);
                    },
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
