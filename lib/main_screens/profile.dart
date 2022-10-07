import 'package:flutter/material.dart';
import 'package:multi_store_app/customer-screens/customer_orders.dart';
import 'package:multi_store_app/customer-screens/wishlist.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/welcome_screen.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.brown],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      opacity: constraints.biggest.height <= 120 ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        'account'.toUpperCase(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.brown],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/inapp/guest.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'guest'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            child: TextButton(
                              onPressed: (() {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const CartScreen(
                                      back: AppBarButton(),
                                    );
                                  },
                                ));
                              }),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.yellow,
                            child: TextButton(
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerOrders(),
                                  ),
                                );
                              }),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Orders',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: TextButton(
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WishListScreen(),
                                  ),
                                );
                              }),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Wishlist',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: Image.asset('images/inapp/logo.jpg'),
                          ),
                          const ProfileHeaderLabel(
                              headerLabel: '  Account Info  '),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: const [
                                  RepeatedListTile(
                                    title: 'Email Address',
                                    subTitle: 'example@email.com',
                                    icon: Icons.email,
                                  ),
                                  YellowDivider(),
                                  RepeatedListTile(
                                    title: 'Phone No.',
                                    subTitle: '+1265732',
                                    icon: Icons.phone,
                                  ),
                                  YellowDivider(),
                                  RepeatedListTile(
                                    title: 'Address',
                                    subTitle: 'Meridian Park-unit 4 block c7',
                                    icon: Icons.location_pin,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const ProfileHeaderLabel(
                              headerLabel: '  Account Settings  '),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  RepeatedListTile(
                                    icon: Icons.edit,
                                    onPressed: () {},
                                    title: 'Edit Profile',
                                  ),
                                  const YellowDivider(),
                                  RepeatedListTile(
                                    icon: Icons.lock,
                                    onPressed: () {},
                                    title: 'Change Password',
                                  ),
                                  const YellowDivider(),
                                  RepeatedListTile(
                                    icon: Icons.logout,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, WelcomeScreen.welcomeScreen);
                                    },
                                    title: 'Log out',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  const RepeatedListTile({
    Key? key,
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onPressed, //set it to a null value not to make it required
  }) : super(key: key);

  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  const ProfileHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);
  final String headerLabel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
