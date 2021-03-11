import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mgt_shop_app/providers/orders.dart' show Orders;
import 'package:st_mgt_shop_app/widgets/app_drawer.dart';
import 'package:st_mgt_shop_app/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    // commented above as it would make build method recalled each time due to..
    //.. the FutureBuilder down below, hence cause the page to be in a constant loop
    print('building Orders');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        //future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              //..
              // do Error Handling stuff
              return Center(
                child: Text('An error occured!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(
                    orderData.orders[i],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

//var _isLoading = false;
// @override
// void initState() {
//   _isLoading = true;
//   Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//     setState(() {
//       _isLoading = false;
//     });
//   });
//   //--------------------- OR ----------------------//
//   //Future.delayed(Duration.zero).then((_) async {
//   // setState(() {
//   //   _isLoading = true;
//   // });
//   //await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//   //setState(() {
//   //  _isLoading = false;
//   //});
//   //});
//   super.initState();
// }
