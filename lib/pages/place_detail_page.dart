import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/components/schedule_text.dart';
import 'package:sportivo/models/place_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PlaceDetailPage extends StatelessWidget {
  final placeItem;

  const PlaceDetailPage({
    Key? key,
    required this.placeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final provider = Provider.of<PlaceList>(context);
    final category = provider.categoryItem(placeItem.id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.h,
            pinned: true,
            backgroundColor: category['color'],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                placeItem.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider(
                    items: [
                      for (var index = 0; index < placeItem.urlImage.length; index++)
                        Center(
                            child: Image.network(
                          placeItem.urlImage[index],
                          fit: BoxFit.cover,
                          height: (375 + height).h,
                        ))
                    ],
                    options: CarouselOptions(
                        height: (375 + height).h,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayInterval: Duration(seconds: 5),
                        viewportFraction: 1),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Horários',
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              ScheduleText(
                day: 'Segunda',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Terça',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Quarta',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Quinta',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Sexta',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Sábado',
                time: '08:00   -   16:00',
              ),
              ScheduleText(
                day: 'Domingo',
                time: '08:00   -   16:00',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Endereço',
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: category['color'],),
                  title: Text(
                    placeItem.address,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    'CEP: 58036605',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  isThreeLine: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Descrição',
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(placeItem.description),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Contatos',
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FaIcon(FontAwesomeIcons.instagram),
                    FaIcon(FontAwesomeIcons.whatsapp),
                    FaIcon(FontAwesomeIcons.phone)
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
