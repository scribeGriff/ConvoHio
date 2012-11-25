# ConvoHio #

## A server side signal processing library in Dart ##

This application is intended to be used on the server with the ConvoLab signal processing library.  Contains dart:io dependency to allow the signal processing of files residing on the server if desired.  Data can then be either saved to a file in tab deliminated format or sent to the web using websockets.    


## Example Usage: ##
To compute the partial sums of fourier series of a soundwave sample whose data is stored on the server, one could do the following:

    import 'package:convohio/convohio.dart';
    import 'package:convolab/convolab.dart';
    
    void main() {
      List waveform = sound(4);
      List kvals = [1, 40, 80];
      var fourier = fsps(waveform, kvals);
      if (fourier != null) {
        exportToWeb(fourier.jsonData, 'local', 8080);
        exportToFile(fourier.psums, 'local/data/fsps.txt');
        print('We have computed ${fourier.psums.length} Fourier series.');
        if (fourier.psums[kvals[0]].every(f(element) => element is Complex)) {
          print('The computed Fourier series is of type Complex.');
        } else {
          print('The computed Fourier series is not Complex.');
        }
      } else {
        print('There was an error computing the Fourier series');
      }
    }

The algorithm fsps() computes the fourier series and is contained in the ConvoLab library.  The exportToWeb() and exportToFile() are part of the ConvoHio library.





