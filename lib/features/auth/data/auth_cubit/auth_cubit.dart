
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/auth/data/auth_cubit/auth_states.dart';
import 'package:task_project/features/auth/presentation/model_view/users_model.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit(AuthStates initialState) : super(initialState);
  Future<void> loginUser({required String email , required String password}) async {
    try {
      emit(LoginLoading());
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong-password'));
      }
    }catch(ex){
      emit(LoginFailure(errorMessage: "Something wrong"));
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
      emit(RegisterFailure(errorMessages: "something is wrong!"));
    }
  }
}