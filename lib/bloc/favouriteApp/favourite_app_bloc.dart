import 'package:bloc/bloc.dart';
import 'package:bloc_counter/bloc/favouriteApp/favourite_App_state.dart';
import 'package:bloc_counter/bloc/favouriteApp/favourite_app_events.dart';
import 'package:bloc_counter/model/favourite_item_model.dart';

import '../../repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvents, FavouriteItemState>{
  List<FavouriteItemModel> favouriteList=[];
  List<FavouriteItemModel> temFavouriteList=[];
  FavouriteRepository favouriteRepository;
  FavouriteBloc(this.favouriteRepository):super(FavouriteItemState()){
on<FetchFavouriteList>(fetchList);
on<FavouriteItem>(addFavouriteItem);
on<SelectItem>(_selectItem);
on<UnSelectItem>(_unSelectItem);
on<DeleteItem>(_deleteItem);
  }

  void fetchList(FetchFavouriteList event, Emitter<FavouriteItemState> emit ) async{
  favouriteList= await favouriteRepository.fetchItem();
emit(state.copyWith(favouriteItemList:List.from(favouriteList)  , listStatus:ListStatus.success  ));
  }

  void addFavouriteItem(FavouriteItem event, Emitter<FavouriteItemState> emit){
final index = favouriteList.indexWhere((element) => element.id== event.item.id);

favouriteList[index]=event.item;
emit(state.copyWith(favouriteItemList: List.from(favouriteList)));
  }


  void _selectItem(SelectItem event, Emitter<FavouriteItemState> emit){
   temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteItemState> emit){
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }
  void _deleteItem(DeleteItem event, Emitter<FavouriteItemState> emit) async{
for(int i=0 ; i< temFavouriteList.length ; i++ ){
  favouriteList.remove(temFavouriteList[i]);
}
temFavouriteList.clear();

    emit(state.copyWith(
      favouriteItemList: List.from(favouriteList),
        temFavouriteItemList: List.from(temFavouriteList)

    ));
  }

}