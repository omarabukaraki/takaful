// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

// ignore: must_be_immutable
class PostSuccess extends PostState {
  List<PostModel> posts = [];
  PostSuccess({required this.posts});
}

class PostLodging extends PostState {}

class PostFailure extends PostState {}
