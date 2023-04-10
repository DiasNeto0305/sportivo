import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                padding: EdgeInsets.only(top: 16.h + height.h, right: 16.w, left: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Constants.APP_NAME.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
                  ],
                ),
              ),
              Padding(
                padding: paddingDefault(),
                child: Text(
                  sugestoes,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Carousel(
                carouselName: sugestoes,
              ),
              Padding(
                padding: paddingDefault(),
                child: Text(
                  proximos,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
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
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              for (var index = 0; index < provider.favorites.length; index++)
                Center(child: FavoriteCards(favoriteItem: provider.favorites[index]))
            ],)
    );
  }
}