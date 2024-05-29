import 'package:bloc_counter/bloc/posts/posts_bloc.dart';
import 'package:bloc_counter/bloc/posts/posts_event.dart';
import 'package:bloc_counter/bloc/posts/posts_state.dart';
import 'package:bloc_counter/ui/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override

  void initState(){
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("Api Get"),
      ),
      body: BlocBuilder<PostBloc,PostStates>(
        builder:(context,state){
          switch(state.postStatus){
            case PostStatus.loading:
              return CircularProgressIndicator();
            case PostStatus.failure:
              return Text(state.message.toString());
            case PostStatus.success:
              return Column(
                children: [
                 TextFormField(
                   decoration: InputDecoration(
                     hintText:  "Search With Email",
                     border: OutlineInputBorder(),
                   ),
                   onChanged: (filterKey){
                     context.read<PostBloc>().add(SearchItem(filterKey));
                   },
                 ),
                  Expanded(
                    child: state.searchMessage.isNotEmpty ?
                    Center(child: Text(state.searchMessage.toString())) :
                    ListView.builder(
                      itemCount:state.tempList.isEmpty ?  state.postList.length : state.tempList.length,
                        itemBuilder: (context,index){
                        if(state.tempList.isNotEmpty){
                          final item = state.tempList[index];
                          return Card(
                            child: ListTile(
                              title: Text(item.email),
                              subtitle: Text(item.body),
                            ),
                          );
                        }else{
                          final item = state.postList[index];
                          return Card(
                            child: ListTile(
                              title: Text(item.email),
                              subtitle: Text(item.body),
                            ),
                          );
                        }

                        }
                    ),
                  ),
                ],
              );
          }
        }
      ),
    );
  }
}
