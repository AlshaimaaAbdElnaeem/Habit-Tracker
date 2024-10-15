import 'package:flutter/material.dart';
import 'package:task_project/Habit_firebase.dart';

import '../../../../core/util/color.dart';
import '../../../../core/util/methods.dart';
import '../../../../core/util/strings.dart';
import '../../../../core/widgets/custom_button.dart';

class CreateCustomHabit extends StatefulWidget {
  const CreateCustomHabit({super.key, required this.userId});
final String userId ;
  @override
  State<CreateCustomHabit> createState() => _CreateCustomHabitState();
}
final TextEditingController _taskName = TextEditingController();
 final TextEditingController _timeController = TextEditingController();
final _formKey = GlobalKey<FormState>();
TextEditingController _dateController = TextEditingController();
class _CreateCustomHabitState extends State<CreateCustomHabit> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ); if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125.0),
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: AppBar(
            backgroundColor: AppColors.primaryColor,
            title:const Text(
              "Add New Habit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Image.asset("assets/images/card_image.png"),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top:20.0 , left: 10.0 , right: 10.0),
              child: Column(
                children: [
                  const Padding(
                   padding:  EdgeInsets.all(10.0),
                   child:  Text("What do you want to do ? ",textAlign: TextAlign.start , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 24),),
                 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: _buildTextField(
                      label: "Habit's name",
                      isObscure: false,
                      controller: _taskName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name of habit is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid Name of habit ';
                        }
                        return null;
                      },
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Habit's time",
                fillColor: Colors.white.withOpacity(0.8),
                labelStyle: TextStyle(color: Colors.blue[900]),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                color: Colors.blue[900]!, // Border color
                width: 2,)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.blue[400]!, // Enabled border color
                        width: 2,),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor, // Focused border color
                        width: 2,
                      ),
                    ),
                  ),
                  onTap: () => _selectTime(context),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0 , right: 16.0 , bottom: 16.0),
                    child: TextField(
                      controller:_dateController ,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Habit's Date",
                        fillColor: Colors.white.withOpacity(0.8),
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.blue[900]!, // Border color
                              width: 2,)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.blue[400]!, // Enabled border color
                            width: 2,),),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor, // Focused border color
                            width: 2,
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: CustomButton(text: 'Continue', onPressed:(){
                      print(widget.userId);
                      Habit newHabit=new Habit(id:widget.userId, title: _taskName.text.trim(), createdAt: _dateController.text.trim().toString(), practiceTime: _timeController.text.trim().toString(),);
                      newHabit.addHabit(_taskName.text.trim());
                      _showCardDialog(context);
                    } ),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
  Widget _buildTextField(
      {required String label,
        required bool isObscure,
        required TextEditingController controller,
        required  String? Function(String?) validator ,
        Function ? onTap  ,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(

        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        labelStyle: TextStyle(color: Colors.blue[900]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue[900]!, // Border color
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue[400]!, // Enabled border color
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.primaryColor, // Focused border color
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
  void _showCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content:const SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.check_circle, color: Colors.green, size: 40),
                   SizedBox(height: 10),
                   Text(
                    'Adding your habit successfully!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الـ Dialog
                },
                child:const Text('ok'),
              ),
            ),
          ],
        );
      },
    );
  }
}
