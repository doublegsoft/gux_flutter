
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListEvent {

}

class ListInitEvent extends ListEvent {

}

class ListLoadEvent extends ListEvent {

  final int? start;

  final int limit;

  final bool silent;

  ListLoadEvent({
    this.start,
    this.limit = 15,
    this.silent = false,
  });

}

class ListWhichState {

  final Map? data;

  ListWhichState({
    this.data,
  });
}

class ListInitialState extends ListWhichState {

}

class ListLoadingState extends ListWhichState {

}

class ListLoadedState extends ListWhichState {

}

class ListBloc extends Bloc<ListEvent, ListWhichState> {

  List loadedItems = [];

  int start = 0;

  ListBloc() : super(ListWhichState()) {
    on<ListLoadEvent>((event, emit) async {
      if (!event.silent) {
        emit(ListLoadingState());
      }
      await Future.delayed(Duration(seconds: 2),);
      if (event != null && event.start == 0)  {
        loadedItems = [];
        start = 0;
      }
      for (int i = 0; i < event.limit; i++) {
        loadedItems.add({
          'index': (start + i + 1),'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
        });
      }
      start += event.limit;
      emit(ListLoadedState());
    });
    on<ListInitEvent>((event, emit) async {
      emit(ListInitialState());
    });
  }

  Future<Map> readFromRemote() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 200,));
    return {'name': 'hello', 'height': 188};
  }

  Future<Map> saveIntoRemote() async {
    await Future.delayed(Duration(seconds: 2, milliseconds: 200,));
    return {};
  }
}