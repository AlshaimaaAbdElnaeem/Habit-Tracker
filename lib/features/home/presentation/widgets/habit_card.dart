import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_project/core/functions/show_snack_bar.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/core/util/custom_text_style.dart';
import 'package:task_project/features/home/data/habit_states.dart';
import 'package:task_project/features/home/presentation/widgets/image_and_next_button_in_card.dart';

import '../../../../Habit_firebase.dart';
import '../../data/habit_cubit.dart';

class HabitCard extends StatefulWidget {
  const HabitCard({super.key, required this.habitId});
final String habitId;
  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
   List<Habit> habit =[];
  bool isLoading = false ;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HabitCubit , HabitStates>(
      listener: (context, state){
if (state is HabitError){
  isLoading = false ;
  showSnackBar(context, state.error);
}else if (state is HabitsLoading){
  isLoading = true ;

}else if(state is HabitsLoaded){
   isLoading = false ;
   habit = state.habits;
}else if (state is HabitsUpdatedSuccessfully){
  BlocProvider.of<HabitCubit>(context).fetchHabitsById(widget.habitId , DateTime.now().toLocal().toIso8601String().split(
      'T')[0] );
}
      },
      builder: (context , state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.52,
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: ListView.builder(
              itemCount:habit.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                margin: const EdgeInsets.all(6),
                width: screenWidth*0.1,
                height: screenHeight*0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [AppColors.cardColor1, AppColors.cardColor2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            habit[index].title,
                            style: CustomTextStyle.titleStyle,
                          ),
                          Text(
                            habit[index].practiceTime,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${habit[index].createdAt.toDate().toIso8601String().split('T')[0]}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                BlocProvider.of<HabitCubit>(context).updateHabit(habit[index].habitId,true);
                              });
                            },
                            child:habit[index].isCompleted ==false ? Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error, color: AppColors.primaryColor),
                                 const Text(
                                    "Pending",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ) : Container(
                          margin: const EdgeInsets.only(top: 8.0),
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color:  AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                   Icon(
                    Icons.check_circle_rounded,
                   color:Colors.white,
                   ),
                       Text(
                        "Completed",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ) ,
                          ),
                        ],
                      ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/card_image.png",width: screenWidth*0.1,
                          height:screenHeight*0.1,),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              habit[index].deleteHabit(habit[index].habitId);
                              BlocProvider.of<HabitCubit>(context).fetchHabitsById(widget.habitId , DateTime.now().toLocal().toIso8601String().split(
                                  'T')[0] );
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                ),
              ); },
            ),
          ),
        );
      }
    );
  }
}
