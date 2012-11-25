part of convohio;

// TODO consolidate these three classes into one class.
//class Import {
//}

/* ****************************************************** *
 *   InputListHandler returns list                        *
 *   Library: ConvoHio (c) 2012 scribeGriff               *
 * ****************************************************** */

class InputListHandler {
  List prepareList(var fileOrList, [String syncOrAsync = 'sync']) {
    List<int> _unsortedList;
    if (fileOrList is String) {
      if (syncOrAsync == 'sync') {
        _unsortedList = listFromFileSync(fileOrList);
      } else {
        _unsortedList = listFromFileAsync(fileOrList);
      }
    } else if (fileOrList is List) {
      if (fileOrList.every(f(element) => element is int)) {
        _unsortedList = new List.from(fileOrList);
      } else {
        print("The input data is not formatted correctly.");
        print("All elements must be integers.");
        return(null);
      }
    }
    return _unsortedList;
  }

  List<int> listFromFileSync(String filename) {
    List<String> _buffin;
    List<int> _buffer = [];
    File fileHandle = new File(filename);
    try {
      _buffin = fileHandle.readAsLinesSync();
    } catch(error) {
      print("There was an error opening the file:\n$error");
      return(null);
    }
    //If successfully read from file, try to parse the lines
    //as integers to _buffer and return.
    try {
      _buffin.forEach((element) {
        if(!element.isEmpty) _buffer.add(int.parse(element.trim()));
        });
      return _buffer;
    } catch(error) {
      print("There was an error reading the input data:\n$error");
      return(null);
    }
  }

  List<int> listFromFileAsync(String filename) {
    List<String> _buffer;
  }
}

/* ****************************************************** *
 *   Double InputListHandler returns Double list          *
 *   Library: ConvoHio (c) 2012 scribeGriff               *
 * ****************************************************** */

class DoubleInputListHandler {
  List prepareList(var fileOrList, [String syncOrAsync = 'sync']) {
    List<num> _numList;
    if (fileOrList is String) {
      if (syncOrAsync == 'sync') {
        _numList = listFromFileSync(fileOrList);
      } else {
        _numList = listFromFileAsync(fileOrList);
      }
    } else if (fileOrList is List) {
      if (fileOrList.every(f(element) => element is num)) {
        _numList = new List.from(fileOrList);
      } else {
        print("The input data is not formatted correctly.");
        print("Elements must be type num or complex.");
        return(null);
      }
    }
    return _numList;
  }

  List<num> listFromFileSync(String filename) {
    List<String> _buffin;
    List<num> _buffer = [];
    File fileHandle = new File(filename);
    try {
      _buffin = fileHandle.readAsLinesSync();
    } catch(error) {
      print("There was an error opening the file:\n$error");
      return(null);
    }
    //If successfully read from file, try to parse the lines
    //as doubles to _buffer and return.
    try {
      _buffin.forEach((element) {
        if(!element.isEmpty) _buffer.add(double.parse(element.trim()));
        });
      return _buffer;
    } catch(error) {
      print("There was an error reading the input data:\n$error");
      return(null);
    }
  }

  List<num> listFromFileAsync(String filename) {
    //Not implemented yet...
    return(null);
  }
}

/* ****************************************************** *
 *   Complex InputListHandler returns Complex list        *
 *   Library: ConvoHio (c) 2012 scribeGriff               *
 * ****************************************************** */

class ComplexInputListHandler {
  List prepareList(var fileOrList, [String syncOrAsync = 'sync']) {
    List<num> _numList;
    List<Complex> _complexList = [];
    if (fileOrList is String) {
      if (syncOrAsync == 'sync') {
        _numList = listFromFileSync(fileOrList);
      } else {
        _numList = listFromFileAsync(fileOrList);
      }
      // Convert list to complex.
      _complexList = toComplex(_numList);
    } else if (fileOrList is List) {
      if (fileOrList.every(f(element) => element is num)) {
        // Convert list to complex.
        _complexList = toComplex(fileOrList);
      } else if (fileOrList.every(f(element) => element is Complex)) {
        _complexList = new List.from(fileOrList);
      } else {
        print("The input data is not formatted correctly.");
        print("Elements must be type num or complex.");
        return(null);
      }
    }
    return _complexList;
  }

  List<num> listFromFileSync(String filename) {
    List<String> _buffin;
    List<num> _buffer = [];
    File fileHandle = new File(filename);
    try {
      _buffin = fileHandle.readAsLinesSync();
    } catch(error) {
      print("There was an error opening the file:\n$error");
      return(null);
    }
    //If successfully read from file, try to parse the lines
    //as doubles to _buffer and return.
    try {
      _buffin.forEach((element) {
        if(!element.isEmpty) _buffer.add(double.parse(element.trim()));
        });
      return _buffer;
    } catch(error) {
      print("There was an error reading the input data:\n$error");
      return(null);
    }
  }

  List<num> listFromFileAsync(String filename) {
    //Not implemented yet...
    return(null);
  }
}