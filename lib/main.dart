import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mgt_shop_app/providers/cart.dart';
import 'package:st_mgt_shop_app/providers/orders.dart';
import 'package:st_mgt_shop_app/providers/products.dart';
import 'package:st_mgt_shop_app/screens/auth_screen.dart';
import 'package:st_mgt_shop_app/screens/cart_screen.dart';
import 'package:st_mgt_shop_app/screens/edit_product_screen.dart';
import 'package:st_mgt_shop_app/screens/orders_screen.dart';
import 'package:st_mgt_shop_app/screens/product_detail_scree.dart';
import 'package:st_mgt_shop_app/screens/products_overview_screen.dart';
import 'package:st_mgt_shop_app/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        //home: ProductsOverviewScreen(),
        home: AuthScreen(),
        routes: {
          //ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Center(
//         child: Text('Lets build this app'),
//       ),
//     );
//   }
// }
