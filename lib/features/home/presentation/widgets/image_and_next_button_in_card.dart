import 'package:flutter/material.dart';

class ImageAndNextButton extends StatelessWidget {
  const ImageAndNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          const Image(
            image: AssetImage(
              "assets/images/man.jpg",
            ),
            width: 160,
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.keyboard_double_arrow_right_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
