import 'package:chat_call_core/core/local/shared_pref_source.dart';
import 'package:chat_call_core/core/models/expert_model.dart';
import 'package:chat_call_core/core/models/user_model.dart';
import 'package:chat_call_core/shared/base/base_bloc.dart';
import 'package:chat_call_core/shared/base/base_event.dart';
import 'package:chat_call_core/shared/base/base_state.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/service/account_repository.dart';
import 'package:sharing/remote/network/fetch_data.dart';

@injectable
class ExpertBloc extends BaseBloc {
  final AccountRepository accountRepository;
  final SharePrefSource sharePrefSource;

  ExpertBloc(this.accountRepository, this.sharePrefSource);

  @override
  void onMapEventToState() {
    on<GetExpertListEvent>(_onGetExpert);
    on<GetSpecializesistEvent>(_onGetSpecializes);
    on<GetUserEvent>(_onGetUser);
    on<SignOutEvent>(_onSignOut);
  }

  _onGetExpert(GetExpertListEvent event, emit) async {
    await accountRepository.getExpertList(
        specialize:
            event.specialize?.isNotEmpty == true ? event.specialize : null,
        funDataServer: (data) {
          final result = data as FetchData<List<ExpertModel>>;
          return emit(SuccessDataState(data: result.data));
        },
        funError: (error) {
          return emit(safeErrorState(error: error));
        });
  }

  _onGetSpecializes(event, emit) async {
    emit(LoadingUiState(duration: 6));
    await accountRepository.getSpecializesList(funDataServer: (data) {
      final result = data as FetchData<List<String>>;
      emit(CloseLoadingState());
      return emit(SuccessDataState(data: result.data));
    }, funError: (error) {
      emit(CloseLoadingState());
      return GetSpecializesistState();
    });
  }

  _onGetUser(event, emit) async {
    await accountRepository.getUser(funDataServer: (data) {
      sharePrefSource.cacheUser(data: data.data);
      final user = data.data as UserModel?;
      if (user != null) {}
    }, funError: (error) {
      return emit(safeErrorState(error: error));
    });
  }

  _onSignOut(event, emit) async {
    emit(LoadingState());
    await accountRepository.signOut();
    await sharePrefSource.resetAllCache();
    emit(SuccessLogOutState());
  }
}

class GetExpertListEvent extends BaseEvent {
  final String? specialize;
  GetExpertListEvent({this.specialize});
}

class GetSpecializesistEvent extends BaseEvent {
  GetSpecializesistEvent();
}

class GetUserEvent extends BaseEvent {
  GetUserEvent();
}

class SignOutEvent extends BaseEvent {}

class SuccessLogOutState extends BaseState {
  SuccessLogOutState();
}

class GetSpecializesistState extends BaseState {}
