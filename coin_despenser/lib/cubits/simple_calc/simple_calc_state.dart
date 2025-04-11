part of 'simple_calc_cubit.dart';

abstract class SimpleCalcState extends Equatable {
  const SimpleCalcState();

  @override
  List<Object?> get props => [];
}

class SimpleCalcCalculated extends SimpleCalcState {
  final Map<String, num> breakdown;
  final num totalChange;

  const SimpleCalcCalculated(this.breakdown, this.totalChange);

  @override
  List<Object?> get props => [breakdown, totalChange];
}

class SimpleCalcError extends SimpleCalcState {
  final String message;

  const SimpleCalcError(this.message);

  @override
  List<Object?> get props => [message];
}
