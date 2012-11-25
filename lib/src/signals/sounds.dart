part of convohio;

/* ****************************************************** *
 *   Class _Waves: A simple sound wave generator.         *
 *   Library: ConvoHio (c) 2012 scribeGriff               *
 * ****************************************************** */

List sound([num sampleNum = 1])  {
  String filename = "lib/external/data/sound${sampleNum.toInt()}.txt";
  return new DoubleInputListHandler().prepareList(filename);
}
