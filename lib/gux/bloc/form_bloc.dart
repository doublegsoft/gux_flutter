
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormEvent {

}

class FormInitEvent extends FormEvent {

}

class FormReadEvent extends FormEvent {

}

class FormSaveEvent extends FormEvent {

}

class FormWhichState {

  final Map? data;

  FormWhichState({
    this.data,
  });
}

class FormInitialState extends FormWhichState {

}

class FormLoadingState extends FormWhichState {

}

class FormUpdatingState extends FormWhichState {

}

class FormReadState extends FormWhichState {

  final Map? data;

  FormReadState({
    required this.data,
  });

}

class FormSavedState extends FormWhichState {
  final Map data;

  FormSavedState({
    required this.data,
  });
}

class FormBloc extends Bloc<FormEvent, FormWhichState> {

  FormBloc() : super(FormWhichState()) {
    on<FormReadEvent>((event, emit) async {
      emit(FormLoadingState());
      Map data = await readFromRemote();
      emit(FormReadState(data: data));
    });
    on<FormSaveEvent>((event, emit) async {
      emit(FormUpdatingState());
      Map data = await saveIntoRemote();
      emit(FormSavedState(data: data));
    });
    on<FormInitEvent>((event, emit) async {
      emit(FormInitialState());
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