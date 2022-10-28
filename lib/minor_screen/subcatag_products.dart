import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class SubCategProducts extends StatefulWidget {
  const SubCategProducts(
      {Key? key, required this.title, required this.maincategName})
      : super(key: key);
  final String title;
  final String maincategName;

  @override
  State<SubCategProducts> createState() => _SubCategProductsState();
}

class _SubCategProductsState extends State<SubCategProducts> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.maincategName)
        .where('subcateg', isEqualTo: widget.title)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarButton(),
        centerTitle: true,
        title: AppBarTittle(title: widget.title),
      ),
      body: StreamBody(
        productsStream: _productsStream,
      ),
    );
  }
}
