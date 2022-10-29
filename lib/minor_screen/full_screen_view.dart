import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class FullScreenView extends StatefulWidget {
  const FullScreenView({Key? key, required this.imagesList}) : super(key: key);
  final List<dynamic> imagesList;
  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int selectedIndex = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarButton(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                '${index + 1}/${widget.imagesList.length}',
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 8,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.46,
              width: width * 0.70,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: images(),
              ),
            ),
            const SizedBox(height: 98),
            SizedBox(
              height: height * 0.2,
              child: imageView(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> images() {
    return List.generate(
      widget.imagesList.length,
      (index) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 1)),
          child: InteractiveViewer(
            transformationController: TransformationController(),
            child: Image.network(
              widget.imagesList[index].toString(),
              fit: BoxFit.cover,
              width: 45,
            ),
          ),
        );
      },
    );
  }

  ListView imageView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.imagesList.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            _controller.jumpToPage(index);
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 4,
                  color: selectedIndex == index ? Colors.yellow : Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              //clip rect forces its chid to react according to the border radius we gave it
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imagesList[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}
