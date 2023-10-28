// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as int1;
import 'package:webe/consts/consts.dart';
import 'package:webe/order_sceen/components/order_status.dart';
import 'package:webe/order_sceen/order_placed_details.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "Order Dtails".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: blueColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data['order_placed'],
              ),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "On delivery",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      d1: data['order_code'],
                      d2: data['shipping_methode'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlacedDetails(
                      d1: int1.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_methode'],
                      title1: "Order date",
                      title2: "payment Method"),
                  orderPlacedDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            // "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            // "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                "${data['total_amount']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(redcolor)
                                    .make(),
                              ]),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.outerShadowSm.white.make(),
              const Divider(),
              10.heightBox,
              "Orderred Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(data['orders'][index]['color']),
                          )),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowSm
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
