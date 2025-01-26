
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}
class GetProfileFailureState extends ProfileState {}