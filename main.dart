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
    Map<int, List<int>> crommos =
        List.generate(2, (_) => generateRandomCrommo()).asMap();

    print(crommos);
    crommos = rateCrommos(crommos);
    print(crommos);
  }

  List<int> generateRandomCrommo() {
    final List<int> crommo = [];

    final rand = Random();

    while (crommo.length < 5) {
      final generated = rand.nextInt(5);
      if (!crommo.contains(generated)) {
        crommo.add(generated);
      }
    }

    return crommo;
  }

  Map<int, List<int>> rateCrommos(Map<int, List<int>> crommos) {
    final rated = crommos.map(
      (index, crommo) => MapEntry(
        getFitness(crommo),
        crommo,
      ),
    );

    return rated;
  }

  int getFitness(List<int> crommo) {
    int fitVal = 0;

    for (int j = 0; j < crommo.length - 1; j++) {
      final currentPoint = points[crommo[j]];
      final travelTime = currentPoint[crommo[j + 1]];
      fitVal += travelTime;
    }

    print('Crommo takes $fitVal minutes to travel all points');
    return fitVal;
  }

  void printCrommos(Map<int, List<int>> crommos) {
    crommos.forEach((index, crommo) {
      print('Crommo val: $index');
      print(crommo);
    });
  }
}

void main() {
  final g = Genetic();
  g.main();
}
