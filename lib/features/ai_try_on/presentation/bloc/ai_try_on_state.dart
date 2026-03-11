import 'package:equatable/equatable.dart';
import '../../domain/entities/try_on_result.dart';

abstract class AiTryOnState extends Equatable {
   const AiTryOnState();
}

class AiTryOnInitial extends AiTryOnState {
   const AiTryOnInitial();

  @override
  List<Object?> get props => [];
}

class AiTryOnGenerating extends AiTryOnState {
   const AiTryOnGenerating();

  @override
  List<Object?> get props => [];
}

class AiTryOnSuccess extends AiTryOnState {
  final TryOnResult result;

   const AiTryOnSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class AiTryOnHistoryLoaded extends AiTryOnState {
  final List<TryOnResult> results;

   const AiTryOnHistoryLoaded({required this.results});

  @override
  List<Object?> get props => [results];
}

class AiTryOnError extends AiTryOnState {
  final String message;

   const AiTryOnError({required this.message});

  @override
  List<Object?> get props => [message];
}
