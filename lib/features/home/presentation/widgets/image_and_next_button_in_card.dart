import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/home/data/habit_cubit.dart';

class ImageAndNextButton extends StatelessWidget {
  const ImageAndNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Image.asset("assets/images/card_image.png",width: screenWidth*0.1,
              height:screenHeight*0.1,),
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
