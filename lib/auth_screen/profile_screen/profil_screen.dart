import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webe/auth_screen/profile_screen/components/edit_profile_screen.dart';
// import 'package:webe/controller/profile_controler.dart';
import 'package:webe/controller/profile_controller.dart';
import 'package:webe/order_sceen/order_screen.dart';
import 'package:webe/services/firestore_services.dart';
import 'package:webe/widgets_common/loading_indicator.dart';
import 'package:webe/wishlist/wishlist_screen.dart';

import '/consts/consts.dart';
import '/widgets_common/bg_widget.dart';
import '../../consts/lists.dart';
import '../../controller/auth_controller.dart';
import '../login_screen.dart';
import 'components/details_card.dart';
// import 'edit_profile_screen.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // FirestoreServices.getCounts();
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(blueColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // users profile button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(Icons.edit, color: whiteColor))
                          .onTap(() {
                        controller.nameController.text = data['name'];
                        // controller.passController.text = data['password'];
                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] != ''
                              ? Image.network(data['imageUrl'],
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.asset(imgProfile2,
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.heightBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              color: whiteColor,
                            )),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                "logout".text.fontFamily(semibold).white.make(),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,

                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var countData = snapshot.data;
                            // print(snapshot.data);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                    count: countData[0].toString(),
                                    title: "in your cart",
                                    width: context.screenWidth / 3.3),
                                detailsCard(
                                    count: countData[1].toString(),
                                    title: "in your wishlist",
                                    width: context.screenWidth / 3.3),
                                detailsCard(
                                    count: countData[2].toString(),
                                    title: " your orders",
                                    width: context.screenWidth / 3.3),
                              ],
                            );
                          }
                        }),

                    // buttons section
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OdrersScreen());

                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());

                                break;

                              default:
                            }
                          },
                          leading:
                              Image.asset(profileButtonsIcon[index], width: 22),
                          title: profileButtonsList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(const EdgeInsets.all(12))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redcolor)
                        .make(),
                  ],
                ),
              ));
            }
          },
        ),
      ),
    );
  }
}
