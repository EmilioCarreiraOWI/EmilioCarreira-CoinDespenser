import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  void calculateWithMod(double? cost, double? tender) {
    if (cost == null || tender == null || tender < cost) return;

    num totalChange = tender - cost;
    Map<String, num> breakdown = {}; // The map to hold the breakdown of the change. A string value of the denomination and a number of how many of that denomination to give. Example: {200: 1, 50: 2}

    // TODO Your code will go here

    // Define the denominations in descending order
    List<int> denominations = [200, 100, 50, 20, 10, 5, 2, 1];

    // calculate the breakdown
    for (int denomination in denominations) {
      if (totalChange >= denomination) {
        int count = (totalChange ~/ denomination).toInt(); // Number of coins/notes of this denomination
        breakdown[denomination.toString()] = count;
        totalChange -= count * denomination; // Reduce the total change
      }
    }

    emit(SimpleCalcCalculated(breakdown, tender - cost));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
