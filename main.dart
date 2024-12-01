import 'dart:math';

class Genetic {
  final points = [
    [0, 2, 9, 3, 6], // point 1
    [2, 0, 4, 3, 8], // point 2
    [9, 4, 0, 7, 3], // point 3
    [3, 3, 7, 0, 3], // point 4
    [6, 8, 3, 3, 0], // point 5
  ];

  void main() {
    Map<int, List<int>> chrommos =
        List.generate(2, (_) => generateRandomChrommo()).asMap();

    print('Start (random chrommossomes) $chrommos');
    chrommos = rateChrommos(chrommos);
    print('Rated $chrommos');
  }

  List<int> generateRandomChrommo() {
    final List<int> chrommo = [];

    final rand = Random();

    while (chrommo.length < 5) {
      final generated = rand.nextInt(5);
      if (!chrommo.contains(generated)) {
        chrommo.add(generated);
      }
    }

    return chrommo;
  }

  Map<int, List<int>> rateChrommos(Map<int, List<int>> chrommos) {
    final rated = chrommos.map(
      (index, chrommo) => MapEntry(
        getFitness(chrommo),
        chrommo,
      ),
    );

    return rated;
  }

  int getFitness(List<int> chrommo) {
    int fitVal = 0;

    for (int j = 0; j < chrommo.length - 1; j++) {
      final currentPoint = points[chrommo[j]];
      final travelTime = currentPoint[chrommo[j + 1]];
      fitVal += travelTime;
    }

    return fitVal;
  }
}

void main() {
  final g = Genetic();
  g.main();
}
