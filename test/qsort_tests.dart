part of chiotests;

/* *************************************************************** *
 *   Unit testing of QuickSort                                     *
 *   Library: ConvoLab (c) 2012 scribeGriff                        *
 * *************************************************************** */

void quickSortTests(String pivot, int compExt, int compInt) {
  // QuickSort
  // number of inversions = n chose 2 = n(n-1)/2 this might be mergesort
  String filename = "test/samples/unsorted_list.txt";
  List<int> unsortedList = new InputListHandler().prepareList(filename);
  QsortResults qsResults;
  List<int> list10;
  List<int> auData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  group('QuickSort algorithm tests:', (){
    test('QuickSort of small internal array - ${pivot} element pivot', (){
      List<int> dataList = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
      qsResults = qsort(dataList, pivot);
      expect(qsResults, isNotNull);
      expect(qsResults.value, equals(compInt));
      expect(qsResults.data, equals(auData));
    });
    test('Quicksort of external file - ${pivot} element pivot', (){
      qsResults = qsort(unsortedList, pivot);
      list10 = qsResults.data.getRange(0, 10);
      expect(qsResults, isNotNull);
      expect(qsResults.value, equals(compExt));
      expect(list10, equals(auData));
    });
  });
}
