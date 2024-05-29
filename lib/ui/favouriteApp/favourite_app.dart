import 'package:bloc_counter/bloc/favouriteApp/favourite_App_state.dart';
import 'package:bloc_counter/bloc/favouriteApp/favourite_app_bloc.dart';
import 'package:bloc_counter/bloc/favouriteApp/favourite_app_events.dart';
import 'package:bloc_counter/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteItemState>(
            builder: (context, state) {
              return Visibility(
                visible: state.temFavouriteItemList.isNotEmpty ? true :false,
                child: IconButton(onPressed: () {
                  context.read<FavouriteBloc>().add(DeleteItem());

                }, icon: Icon(Icons.delete,color: Colors.red,)
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteItemState>
        (builder: (context, state) {
        switch (state.listStatus) {
          case ListStatus.loading:
            return Center(child: CircularProgressIndicator());
          case ListStatus.failure:
            return Text("something went wrong");
          case ListStatus.success :
            return ListView.builder(
                itemCount: state.favouriteItemList.length,
                itemBuilder: (context, index) {
                  final item = state.favouriteItemList[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: state.temFavouriteItemList.contains(item)
                            ? true
                            : false,
                        onChanged: (value) {
                          if (value!) {
                            context.read<FavouriteBloc>().add(
                                SelectItem(item: item));
                          } else {
                            context.read<FavouriteBloc>().add(
                                UnSelectItem(item: item));
                          }
                        },
                      ),
                      title: Text(item.value.toString()),
                      trailing: IconButton(onPressed: () {
                        FavouriteItemModel itemModel = FavouriteItemModel(
                            id: item.id, value: item.value,
                            isFavourite: item.isFavourite ? false : true
                        );

                        context.read<FavouriteBloc>().add(
                            FavouriteItem(item: itemModel));
                      }, icon:
                      item.isFavourite ? Icon(Icons.favorite) :
                      Icon(Icons.favorite_outline)),
                    ),
                  );
                }
            );
        }
      }),
    );
  }
}
