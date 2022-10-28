import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class ElectronicsGalleryScreen extends StatefulWidget {
  const ElectronicsGalleryScreen({Key? key}) : super(key: key);

  @override
  State<ElectronicsGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<ElectronicsGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'electronics')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
