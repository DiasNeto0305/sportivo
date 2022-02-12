import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteCards extends StatefulWidget {
  final favoriteItem;

  const FavoriteCards({Key? key, required this.favoriteItem}) : super(key: key);

  @override
  _FavoriteCardsState createState() => _FavoriteCardsState();
}

class _FavoriteCardsState extends State<FavoriteCards> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? 100.h + 100.h : 100.h,
      width: deviceSize.width * 0.90,
      child: Card(
        color: Color(0xfffafafa),
        elevation: 0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    widget.favoriteItem.urlImage![0],
              ),),
              title: Text(widget.favoriteItem.name as String),
              subtitle: Text('12Km'),
              trailing: IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded ? 100.h: 0,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estilo Teste',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2x R\$ Price',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
