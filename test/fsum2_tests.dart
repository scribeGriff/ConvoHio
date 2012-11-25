part of chiotests;

/* *************************************************************** *
 *   Unit testing of finding the sum of 2 numbers in a list        *
 *   Library: ConvoLab (c) 2012 scribeGriff                        *
 * *************************************************************** */

void findSum2Tests() {
  group('Finding the sum of 2 numbers in a list tests:', (){
    test('FindSum2: large external, match a list of sums:', (){
      String filename = "test/samples/find_sum_list.txt";
      List<int> unsortedList = new InputListHandler().prepareList(filename);
      List<List<int>> auData = [[128636, 102916], [null, null],
                                [295274, 301599], [204524, 443695],
                                [31264, 695048], [null, null],
                                [259160, 729171], [null, null],
                                [null, null]];
      List<int> targetSums = [231552, 234756, 596873, 648219, 726312,
                              981237, 988331, 1277361, 1283379];
      var findSum = fsum2(unsortedList, targetSums);
      expect(findSum, isNotNull);
      expect(findSum.results.length, equals(targetSums.length));
      expect(findSum.results, equals(auData));
      expect(findSum.match, isTrue);
    });
  });
}
