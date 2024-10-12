
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/auth/data/auth_cubit/auth_states.dart';
import 'package:task_project/features/auth/presentation/model_view/users_model.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit(AuthStates initialState) : super(initialState);
  Future<void> loginUser({required String email , required String password}) async {
    try {
      emit(LoginLoading()); // حالة تحميل أثناء تسجيل الدخول.
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess()); // نجاح تسجيل الدخول.
    } on FirebaseAuthException catch (ex) {
      print('FirebaseAuthException: ${ex.code}'); // لطباعة رمز الخطأ للتأكد.

      String errorMessage;
      if (ex.code == 'user-not-found') {
        errorMessage = 'User not found. Please check your email.';
      } else if (ex.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else if (ex.code == 'invalid-credential') {
        errorMessage = 'Incorrect Email or Password , please try again!';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again.';
      }

      emit(LoginFailure(errorMessage: errorMessage));
    } catch (ex) {
      emit(LoginFailure(errorMessage: "Something went wrong. Please try again."));
    }

  }
  Future<void> registerUser({required UserModel userdata}) async {
    CollectionReference users =
    FirebaseFirestore.instance.collection("users");
    try{
      emit(RegisterLoading());
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userdata.email, password: userdata.password);
      users.add({
        "username": userdata.userName ,
        "email" : userdata.email,
        "password" :userdata.password,
      });
      emit(RegisterSuccess());
    }on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMessages: "weak password"));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessages: "email already in use"));
      }
    } catch (ex) {
      emit(RegisterFailure(errorMessages: "Something went wrong!"));
    }
  }
  @override
  void onChange(Change<AuthStates> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}