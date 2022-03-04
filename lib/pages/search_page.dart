import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/components/search/search_button.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/pages/places_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final provider = Provider.of<PlaceController>(context);
    return Padding(
      padding: EdgeInsets.only(top: 16.h + height.h),
      child: Column(
        children: [
          SearchButton(
            label: 'Explorar Locais',
          ),
          GridView.builder(
              padding: EdgeInsets.all(4.h),
              physics: ScrollPhysics(),
              itemCount: provider.categories.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 4),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlacesPage(
                          placesData: provider.filterByCategory(provider.categories[index]['id']),
                          category: provider.categories[index],
                          appBar: true,
                        ),
                      ));
                    },
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Image.asset(
                        provider.categories[index]['urlImage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
