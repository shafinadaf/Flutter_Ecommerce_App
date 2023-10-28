import 'package:webe/widgets_common/exit_dailog.dart';

import '/auth_screen/profile_screen/profil_screen.dart';
import '/cart_screen/cart_screen.dart';
import '/cateogory_screen/cateogory_screen.dart';
import '/consts/consts.dart';
import '/controller/home_controller.dart';
import '/home_screen/home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: category),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];
    var navBody = [
      const HomeScreen(),
      const CateogoryScreen(),
      const CartScreen(),
      const ProfilScreen(),
      // Container(color: Colors.blue),
      // Container(color: Colors.amber),
      // Container(color: Colors.purple),
      // Container(color: Colors.cyan),
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDailog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndrex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentNavIndrex.value,
              selectedItemColor: blueColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value) {
                controller.currentNavIndrex.value = value;
              }),
        ),
      ),
    );
  }
}
