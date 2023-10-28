import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webe/controller/product_controller.dart';
import 'package:webe/services/firestore_services.dart';

import '/consts/consts.dart';
import '/widgets_common/bg_widget.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethode = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethode = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethode;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                        }))),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethode,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    // child: loadingIndicator(),
                    );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: Center(
                    child: "No product found!"
                        .text
                        .color(darkFontGrey)
                        .makeCentered(),
                  ),
                );
              } else {
                var data = snapshot.data!.docs;
                return
                    // /item container
                    Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
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
                                  .outerShadowSm
                                  .padding(const EdgeInsets.all(8))
                                  .make()
                                  .onTap(() {
                                controller.checkIffav(data[index]);
                                Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index]));
                              });
                            }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
