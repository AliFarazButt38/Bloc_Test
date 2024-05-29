
import 'package:bloc/bloc.dart';
import 'package:bloc_counter/bloc/posts/posts_event.dart';
import 'package:bloc_counter/bloc/posts/posts_state.dart';
import 'package:bloc_counter/model/PostModel.dart';
import 'package:bloc_counter/repository/post_repository.dart';
import 'package:bloc_counter/ui/util/enums.dart';

class PostBloc extends Bloc<PostsEvent,PostStates>{
  List<Post> tempList=[];
  PostRepository postRepository= PostRepository();
  PostBloc():super(const PostStates()){
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }

  void _filterList(SearchItem event,Emitter<PostStates> emit) async{
    if(event.stSearch.isEmpty){

      emit(state.copyWith(tempList: [],searchMessage: ''));

    }else{

      // tempList=state.postList.where((element) => element.id.toString()==event.stSearch.toString()).toList();
      tempList=state.postList.where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();

      if(tempList.isEmpty){

        emit(state.copyWith(tempList: tempList,searchMessage: 'No Data Found'));

      }else{

        emit(state.copyWith(tempList: tempList,searchMessage: ''));

      }
    }
    print(tempList.length);
  }

  void fetchPostApi(PostFetched event,Emitter<PostStates> emit) async{
  await postRepository.fetchPost().then((value) {
     emit(state.copyWith(
       postStatus: PostStatus.success,
       message: 'success',
       postList: value,
     ));
   }).onError((error, stackTrace){
    emit(state.copyWith(
      postStatus: PostStatus.failure,
      message: error.toString(),


    ));
   });
  }

}