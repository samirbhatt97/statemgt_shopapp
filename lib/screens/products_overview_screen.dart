import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mgt_shop_app/providers/cart.dart';
import 'package:st_mgt_shop_app/providers/products.dart';
import 'package:st_mgt_shop_app/screens/cart_screen.dart';
import 'package:st_mgt_shop_app/widgets/app_drawer.dart';
import 'package:st_mgt_shop_app/widgets/badge.dart';
// import 'package:provider/provider.dart';
// import 'package:st_mgt_shop_app/providers/products.dart';
//import 'package:st_mgt_shop_app/models/product.dart';
//import 'package:st_mgt_shop_app/widgets/product_item.dart';
import 'package:st_mgt_shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  //final List<Product> loadedProducts = [];

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _initState = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts();
    // Above would result to error as .of(ctx) isnt let on in initState
    //------ Below one is a good hack too, incase 'didChangeDependencies' is not used
    //Future.delayed(Duration.zero).then((_) => Provider.of<Products>(context).fetchAndSetProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initState) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              //print(selectedValue);
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  //productContainer.showFavoriesOnly();
                  _showOnlyFavorites = true;
                } else {
                  //productContainer.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favs'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_bag,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
