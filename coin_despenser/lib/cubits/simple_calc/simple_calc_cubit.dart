import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  void calculateWithMod(double? cost, double? tender) {
    if (cost == null || tender == null) {
      emit(SimpleCalcError("Please enter valid numeric values for cost and tender."));
      return;
    }

    if (tender < cost) {
      emit(SimpleCalcError("The rand note value is incorrect"));
      return;
    }

    num totalChange = tender - cost;
    Map<String, num> breakdown = {}; // The map to hold the breakdown of the change. A string value of the denomination and a number of how many of that denomination to give. Example: {200: 1, 50: 2}

    // TODO Your code will go here

    // Define the denominations in descending order
    List<double> denominations = [200, 100, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

    // Validate the denominations
    if (denominations.any((denomination) => denomination <= 0)) {
      emit(SimpleCalcError("The rand note value is incorrect"));
      return;
    }

    // calculate the breakdown
    for (double denomination in denominations) {
      if (totalChange >= denomination - 0.001) { // Small tolerance for precision
        int count = (totalChange ~/ denomination).toInt();
        breakdown[denomination.toString()] = count;
        totalChange -= count * denomination;
      }
    }

    emit(SimpleCalcCalculated(breakdown, tender - cost));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
