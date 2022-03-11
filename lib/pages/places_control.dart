import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacesControl extends StatefulWidget {
  const PlacesControl({Key? key}) : super(key: key);

  @override
  _PlacesControlState createState() => _PlacesControlState();
}

class _PlacesControlState extends State<PlacesControl> {
  bool _loading = false;
  int _onPressedItem = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
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
              provider.places[index].name,
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
                    color: Colors.indigo,
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                        _onPressedItem = index;
                      });
                      await provider.removePlace(provider.places[index]);
                      setState(() {
                        _loading = false;
                      });
                    },
                    icon: _loading && (_onPressedItem == index)
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          )
                        : Icon(Icons.delete),
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
