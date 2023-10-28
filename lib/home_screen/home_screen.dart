import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webe/cateogory_screen/item_details.dart';
import 'package:webe/controller/home_controller.dart';
import 'package:webe/home_screen/search_screen.dart';
import 'package:webe/services/firestore_services.dart';
import 'package:webe/widgets_common/loading_indicator.dart';

import '/consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
        padding: const EdgeInsets.all(12),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            10.heightBox,
            // Expanded(
            //   child: SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: Column(
            //       children: [
            //         // swipper brand
            //         VxSwiper.builder(
            //             aspectRatio: 16 / 9,
            //             autoPlay: true,
            //             height: 150,
            //             enlargeCenterPage: true,
            //             itemCount: slidersList.length,
            //             itemBuilder: (context, index) {
            //               return Image.asset(
            //                 slidersList[index],
            //                 fit: BoxFit.fill,
            //               )
            //                   .box
            //                   .rounded
            //                   .clip(Clip.antiAlias)
            //                   .margin(const EdgeInsets.symmetric(horizontal: 8))
            //                   .make();
            //             }),
            10.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: List.generate(
            //       2,
            //       (index) => homeButtons(
            //             height: context.screenHeight * 0.15,
            //             width: context.screenWidth / 2.5,
            //             icon: index == 0 ? icTodaysDeal : icFlashDeal,
            //             title: index == 0 ? todayDeal : flashsale,
            //           )),
            // ),
            // //  swiper brands

            // 10.heightBox,
            // VxSwiper.builder(
            //     aspectRatio: 16 / 9,
            //     autoPlay: true,
            //     height: 150,
            //     enlargeCenterPage: true,
            //     itemCount: secondSlidersList.length,
            //     itemBuilder: (context, index) {
            //       return Image.asset(
            //         secondSlidersList[index],
            //         fit: BoxFit.fill,
            //       )
            //           .box
            //           .rounded
            //           .clip(Clip.antiAlias)
            //           .margin(const EdgeInsets.symmetric(horizontal: 8))
            //           .make();
            //     }),
            // 10.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: List.generate(
            //       3,
            //       (index) => homeButtons(
            //             height: context.screenHeight * 0.15,
            //             width: context.screenWidth / 3.5,
            //             icon: index == 0
            //                 ? icTopCategories
            //                 : index == 1
            //                     ? icBrands
            //                     : icTopSeller,
            //             title: index == 0
            //                 ? topCateogories
            //                 : index == 1
            //                     ? brand
            //                     : topSellers,
            //           )),
            // ),
            // 10.heightBox,
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: feeturedCateogories.text
            //       .color(darkFontGrey)
            //       .size(18)
            //       .fontFamily(semibold)
            //       .make(),
            // ),
            // 10.heightBox,
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(
            //       3,
            //       (index) => Column(
            //         children: [
            //           feturedButton(
            //               icon: featuredImages1[index],
            //               title: featuredTitles1[index]),
            //           10.heightBox,
            //           feturedButton(
            //               icon: featuredImages2[index],
            //               title: featuredTitles2[index]),
            //         ],
            //       ),
            //     ).toList(),
            //   ),
            // ),
            // // fetured products

            20.heightBox,

            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: const BoxDecoration(color: blueColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  featuredProducts.text.white.fontFamily(bold).size(18).make(),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                        future: FirestoreServices.getFeaturedProducts(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "No featured products"
                                .text
                                .white
                                .makeCentered();
                          } else {
                            var featuredData = snapshot.data!.docs;
                            return Row(
                              children: List.generate(
                                  featuredData.length,
                                  (index) => Column(
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_imgs'][0],
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${featuredData[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(blueColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index]));
                                      })),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
            // third swiper
            20.heightBox,
            // Container(
            //   height: 150, // Set an appropriate height here
            //   child: VxSwiper.builder(
            //       aspectRatio: 16 / 9,
            //       autoPlay: true,
            //       height: 150,
            //       enlargeCenterPage: true,
            //       itemCount: secondSlidersList.length,
            //       itemBuilder: (context, index) {
            //         return Image.asset(
            //           secondSlidersList[index],
            //           fit: BoxFit.fill,
            //         )
            //             .box
            //             .rounded
            //             .clip(Clip.antiAlias)
            //             .margin(const EdgeInsets.symmetric(horizontal: 8))
            //             .make();
            //       }),
            // ),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: const BoxDecoration(color: darkFontGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  allProducts.text.white.fontFamily(bold).size(18).make(),
                  // all Products(),

                  StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          if (allproductsdata.isEmpty) {
                            return const Text("No products available.");
                          }

                          return GridView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 1,
                                      mainAxisExtent: 290),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      height: 200,
                                      width: 300,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(blueColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 12))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index]));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          ]),
        )));
    //     ],
    //   )),
    // );
  }
}
