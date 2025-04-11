import '../constants/constants.dart';
import '../cubits/simple_calc/simple_calc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCalcView extends StatelessWidget {
  final SimpleCalcCubit _simpleCalcCubit = sl.get<SimpleCalcCubit>();

  final TextEditingController _costController = TextEditingController(text: '25.50');
  final TextEditingController _tenderController = TextEditingController(text: '50');

  void _calculateChange(BuildContext context) {
    _simpleCalcCubit.calculateWithMod(
      double.tryParse(_costController.text),
      double.tryParse(_tenderController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing Store Calculator', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _simpleCalcCubit.clearAll(),
          ),
        ],
      ),
      body: BlocBuilder<SimpleCalcCubit, SimpleCalcState>(
        bloc: _simpleCalcCubit,
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Product Cost:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _costController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter cost',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tender Amount:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _tenderController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter tender amount',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Error message displayed inline
                  Visibility(
                    visible: state is SimpleCalcError,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.red[50],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (state is SimpleCalcError) ? state.message : '',
                                style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () => _simpleCalcCubit.clearAll(), // Clear the error
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(
                                  'Dismiss',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Breakdown message
                  Offstage(
                    offstage: state is! SimpleCalcCalculated || state.breakdown.isEmpty,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Change: R${(state is SimpleCalcCalculated) ? state.totalChange : ''}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            SizedBox(height: 10),
                            ListView(
                              shrinkWrap: true,
                              children: (state is SimpleCalcCalculated)
                                  ? state.breakdown.entries
                                      .map((entry) => Text(
                                            'R${entry.key} x ${entry.value}',
                                            style: TextStyle(fontSize: 16),
                                          ))
                                      .toList()
                                  : [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _calculateChange(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Calculate Change',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
