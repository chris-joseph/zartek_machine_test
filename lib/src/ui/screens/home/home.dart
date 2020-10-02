import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zartek_machine_test/src/blocs/store_bloc.dart';
import 'package:zartek_machine_test/src/models/store/store_list_response.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/login.dart';
import 'package:zartek_machine_test/src/ui/screens/check_out/check_out.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';

import 'components/category_list_item.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with TickerProviderStateMixin {
  TabController _tabController;
  int currentTab = 0;
  String name = "display Name";
  String id = "UID";
  String photo;

  setProfile() {
    if (ObjectFactory().auth.currentUser != null) {
      print(ObjectFactory().auth.currentUser);
      if (ObjectFactory().auth.currentUser.displayName != null) {
        name = ObjectFactory().auth.currentUser.displayName;
        id = 'ID : ' + ObjectFactory().auth.currentUser.uid;
        photo = ObjectFactory().auth.currentUser.photoURL;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    storeBloc.getStore();
    setProfile();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: storeBloc.storeListResponse,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
              StoreListResponse storeResponse = snapshot.data;
              _tabController = TabController(
                  length: storeResponse.tableMenuList.length,
                  vsync: this,
                  initialIndex: currentTab);

              return Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    StreamBuilder<int>(
                        stream: storeBloc.cartCountSubject.stream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (snapshot.data > 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckOut()));
                                }
                              },
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                  ),
                                  Positioned(
                                    right: 0,
                                    width: 17,
                                    bottom: 17,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      radius: 10,
                                      child: Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                  bottom: TabBar(
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(color: Colors.grey),
                    labelStyle: Theme.of(context).textTheme.display1,
                    controller: _tabController,
                    onTap: (value) {
                      setState(() {
                        currentTab = value;
                      });
                    },
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: storeResponse.tableMenuList
                        .map((TableMenuList item) =>
                            Tab(text: item.menuCategory))
                        .toList(),
                  ),
                ),
                drawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 80, 0, 1),
                              Colors.lightGreen,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${DateFormat.jm().format(new DateTime.now())}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: photo == null
                                        ? AssetImage(
                                            'assets/images/firebase.png')
                                        : NetworkImage(ObjectFactory()
                                            .auth
                                            .currentUser
                                            .photoURL),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(name),
                            SizedBox(
                              height: 5,
                            ),
                            Text(id)
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          'Log out',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        onTap: () async {
                          await ObjectFactory().auth.signOut();
                          // change app state...
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()),
                            ModalRoute.withName('/'),
                          ); // close the drawer
                        },
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: storeResponse.tableMenuList
                      .map((item) => new CategoryListBuilder(item))
                      .toList(),
                ),
              );
            case ConnectionState.waiting:
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            case ConnectionState.done:
            default:
              return SizedBox();
          }
        });
  }
}

class CategoryListBuilder extends StatelessWidget {
  CategoryListBuilder(this.tableMenuList);

  final TableMenuList tableMenuList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tableMenuList.categoryDishes.length,
        itemBuilder: (context, index) =>
            CategoryListItem(tableMenuList.categoryDishes[index]));
  }
}
