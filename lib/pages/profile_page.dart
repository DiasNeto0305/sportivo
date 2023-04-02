import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/pages/places_control.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthController>(context).loggedUser;
    final height = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: 16.h + height.h),
      child: Column(
        children: [
          Container(
            height: 160.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  radius: 42.r,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(
                              user?.photoURL as String,
                            )
                          : AssetImage('assets/img/littleboyswimming.png')
                              as ImageProvider,
                      radius: 36.r,
                    ),
                    radius: 40.r,
                  ),
                ),
                Container(
                    height: 100.h,
                    child: VerticalDivider(
                      thickness: 2,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dias de Atividade',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '6 dias seguidos',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    user?.displayName ?? '',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: FaIcon(
                    FontAwesomeIcons.bullseye,
                    size: 24,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                  ),
                  title: Text(
                    'Objetivos',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: FaIcon(
                    FontAwesomeIcons.gamepad,
                    size: 24,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                  ),
                  title: Text(
                    'Fantasy',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: FaIcon(
                    FontAwesomeIcons.wallet,
                    size: 24,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                  ),
                  title: Text(
                    'Controle de Gastos',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: FaIcon(
                    FontAwesomeIcons.cog,
                    size: 24,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                  ),
                  title: Text(
                    'Configurações',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/config');
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PlacesControl()));
                  },
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 24,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                  ),
                  title: Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
