abstract class AuthStates {}
class InitialState extends AuthStates{}
class LoginLoading extends AuthStates{}
class LoginSuccess extends AuthStates{
}

class LoginFailure extends AuthStates{
  String errorMessage ;
  LoginFailure ({required this.errorMessage});

}
class RegisterLoading extends AuthStates{}
class RegisterSuccess extends AuthStates{
}
class RegisterFailure extends AuthStates{
  String errorMessages ;
  RegisterFailure ({required this.errorMessages});
}
