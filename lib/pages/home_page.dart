import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/components/carousel.dart';
import 'package:sportivo/components/cards/favorite_cards.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int title = 0;

  concatName(int pageIndex) {
    setState(() {
      title = pageIndex;
    });
  }

  paddingDefault() {
    return EdgeInsets.only(
      top: 16.h,
      left: 16.w,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final sugestoes = 'Sugestões';
    final proximos = 'Mais Próximos';
    final provider = Provider.of<PlaceController>(context);
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 16.h + height.h, left: 16.w, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Constants.APP_NAME,
                style: TextStyle(
                  fontFamily: 'Alkatra',
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.heart),
                    iconSize: 18,
                    padding: EdgeInsets.all(0),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
                    padding: EdgeInsets.all(0),
                    iconSize: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingDefault(),
          child: Text(
            sugestoes,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Carousel(
          carouselName: sugestoes,
        ),
        Padding(
          padding: paddingDefault(),
          child: Text(
            proximos,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Center(
          child: Carousel(
            carouselName: proximos,
          ),
        ),
        Padding(
          padding: paddingDefault(),
          child: Text(
            'Favoritos',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        for (var index = 0; index < provider.favorites.length; index++)
          Center(child: FavoriteCards(favoriteItem: provider.favorites[index]))
      ],
    ));
  }
}
