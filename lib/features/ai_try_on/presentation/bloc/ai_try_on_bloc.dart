import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/generate_try_on_usecase.dart';
import '../../domain/usecases/get_avatars_usecase.dart';
import '../../domain/usecases/get_fit_profile_usecase.dart';
import '../../domain/usecases/get_try_on_history_usecase.dart';
import 'ai_try_on_event.dart';
import 'ai_try_on_state.dart';

class AiTryOnBloc extends Bloc<AiTryOnEvent, AiTryOnState> {
  final GenerateTryOnUseCase generateTryOnUseCase;
  final GetTryOnHistoryUseCase getTryOnHistoryUseCase;
  final GetAvatarsUseCase getAvatarsUseCase;
  final GetFitProfileUseCase getFitProfileUseCase;

  AiTryOnBloc({
    required this.generateTryOnUseCase,
    required this.getTryOnHistoryUseCase,
    required this.getAvatarsUseCase,
    required this.getFitProfileUseCase,
  }) : super(const AiTryOnInitial()) {
    on<AiTryOnGenerate>(_onGenerate);
    on<AiTryOnLoadAvatars>(_onLoadAvatars);
    on<AiTryOnLoadHistory>(_onLoadHistory);
    on<AiTryOnGetFitProfile>(_onGetFitProfile);
    on<AiTryOnReset>(_onReset);
  }

  Future<void> _onGenerate(
    AiTryOnGenerate event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit(const AiTryOnGenerating());

    final result = await generateTryOnUseCase(
      GenerateTryOnParams(
        productId: event.productId,
        userPhotoBase64: event.userPhotoBase64,
        avatarId: event.avatarId,
      ),
    );

    result.fold(
      (failure) => emit(AiTryOnError(message: failure.message)),
      (tryOnResult) => emit(AiTryOnSuccess(result: tryOnResult)),
    );
  }

  Future<void> _onLoadAvatars(
    AiTryOnLoadAvatars event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit(const AiTryOnLoadingAvatars());

    final result = await getAvatarsUseCase(const NoParams());

    result.fold(
      (failure) => emit(AiTryOnError(message: failure.message)),
      (avatars) => emit(AiTryOnAvatarsLoaded(avatars: avatars)),
    );
  }

  Future<void> _onLoadHistory(
    AiTryOnLoadHistory event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit(const AiTryOnGenerating());

    final result = await getTryOnHistoryUseCase(const NoParams());

    result.fold(
      (failure) => emit(AiTryOnError(message: failure.message)),
      (results) => emit(AiTryOnHistoryLoaded(results: results)),
    );
  }

  Future<void> _onGetFitProfile(
    AiTryOnGetFitProfile event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit(const AiTryOnGenerating());

    final result = await getFitProfileUseCase(const NoParams());

    result.fold(
      (failure) => emit(const AiTryOnFitProfileError(message: 'Belum ada profil ukuran')),
      (profile) => emit(AiTryOnFitProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onReset(
    AiTryOnReset event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit(const AiTryOnInitial());
  }
}
