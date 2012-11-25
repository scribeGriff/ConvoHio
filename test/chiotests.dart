library chiotests;

/* *************************************************************** *
 *   Unit testing                                                  *
 *   Library: ConvoHio (c) 2012 scribeGriff                        *
 * *************************************************************** */

import 'package:convohio/convohio.dart';
import 'package:convolab/convolab.dart';
import 'package:unittest/unittest.dart';

part 'rsel_tests.dart';
part 'fsum2_tests.dart';
part 'msort_tests.dart';
part 'qsort_tests.dart';

void main() {
  group('Initial Tests:', (){
    test('test of randomized selection', () => randomSelectTests());
    test('test of finding sum of 2 numbers', () => findSum2Tests());
    test('test of mergesort', () => mergeSortTests());
    test('test of quicksort', () => quickSortTests('first', 162085, 45));
  });
  group('Quicksort external file - First pivot point:', (){
    test('test of quicksort', () => quickSortTests('last', 164123, 45));
  });
  group('Quicksort external file - Median of 3 pivot point:', (){
    test('test of quicksort', () => quickSortTests('median', 138382, 19));
  });
}
