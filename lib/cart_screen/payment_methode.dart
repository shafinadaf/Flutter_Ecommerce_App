import 'package:webe/consts/consts.dart';
import 'package:webe/consts/lists.dart';
import 'package:webe/controller/cart_controller.dart';
import 'package:webe/home_screen/home.dart';
import 'package:webe/widgets_common/loading_indicator.dart';
import 'package:webe/widgets_common/our_button.dart';

class PaymentMethode extends StatelessWidget {
  const PaymentMethode({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOreder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    controller.palaceMyOrder(
                        orderPaymentMethod:
                            paymentmethodes[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  },
                  color: blueColor,
                  textColor: whiteColor,
                  title: "Place My Order",
                ),
        ),
        appBar: AppBar(
          title: "Choose payment methode"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentmethodesImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? blueColor
                              : Colors.transparent,
                          width: 4),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(paymentmethodesImg[index],
                          width: double.infinity,
                          height: 120,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: true,
                                onChanged: (Value) {},
                              ),
                            )
                          : Container(),
                      paymentmethodes[index]
                          .text
                          .white
                          .fontFamily(bold)
                          .size(16)
                          .make(),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
