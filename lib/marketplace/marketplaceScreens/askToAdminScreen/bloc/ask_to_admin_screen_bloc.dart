import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_state.dart';

class AskToAdminBloc extends Bloc<AskToAdminScreenEvent, AskToAdminScreenState>{
  AskToAdminRepositoryImp? repository;
  AskToAdminBloc({this.repository}) : super(InitialState()) {
    on<AskToAdminScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      AskToAdminScreenEvent event, Emitter<AskToAdminScreenState> emit) async {
    if (event is AskEvent) {
      emit(LoadingState());
      try {
        var model = await repository?.onAsk(
            event.title , event.body );
        if (model != null) {
          emit(SuccessState(model));
        } else {
          emit(const ErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ErrorState(error.toString()));
      }
    }
  }
}