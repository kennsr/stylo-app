import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/generate_try_on_usecase.dart';
import '../../domain/usecases/get_try_on_history_usecase.dart';
import 'ai_try_on_event.dart';
import 'ai_try_on_state.dart';

class AiTryOnBloc extends Bloc<AiTryOnEvent, AiTryOnState> {
  final GenerateTryOnUseCase generateTryOnUseCase;
  final GetTryOnHistoryUseCase getTryOnHistoryUseCase;

  AiTryOnBloc({
    required this.generateTryOnUseCase,
    required this.getTryOnHistoryUseCase,
  }) : super( AiTryOnInitial()) {
    on<AiTryOnGenerate>(_onGenerate);
    on<AiTryOnLoadHistory>(_onLoadHistory);
    on<AiTryOnReset>(_onReset);
  }

  Future<void> _onGenerate(
    AiTryOnGenerate event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit( AiTryOnGenerating());

    final result = await generateTryOnUseCase(
      GenerateTryOnParams(
        productId: event.productId,
        userPhotoBase64: event.userPhotoBase64,
      ),
    );

    result.fold(
      (failure) => emit(AiTryOnError(message: failure.message)),
      (tryOnResult) => emit(AiTryOnSuccess(result: tryOnResult)),
    );
  }

  Future<void> _onLoadHistory(
    AiTryOnLoadHistory event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit( AiTryOnGenerating());

    final result = await getTryOnHistoryUseCase( NoParams());

    result.fold(
      (failure) => emit(AiTryOnError(message: failure.message)),
      (results) => emit(AiTryOnHistoryLoaded(results: results)),
    );
  }

  Future<void> _onReset(
    AiTryOnReset event,
    Emitter<AiTryOnState> emit,
  ) async {
    emit( AiTryOnInitial());
  }
}
