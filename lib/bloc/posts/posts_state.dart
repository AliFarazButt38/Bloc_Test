
import 'package:bloc_counter/ui/util/enums.dart';
import 'package:equatable/equatable.dart';

import '../../model/PostModel.dart';

class PostStates extends Equatable{
  final PostStatus postStatus;
  final List<Post> postList;
  final List<Post> tempList;
  final String message;
  final String searchMessage;

  const PostStates({
    this.postStatus=PostStatus.loading,
    this.postList= const <Post>[],
    this.tempList=const <Post>[],
    this.searchMessage='',
    this.message='',

});

  PostStates copyWith({PostStatus? postStatus , List<Post>? postList, String? message , List<Post>? tempList, String? searchMessage }){
    return PostStates(
     postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      tempList: tempList ?? this.tempList,
      message:  message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage
    );
}

@override
  List<Object?> get props => [postStatus,postStatus,tempList,message,searchMessage];

}
