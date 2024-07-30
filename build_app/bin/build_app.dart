enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        (other is AgriculturalMachinery &&
            other.id == id &&
            other.releaseDate == releaseDate);
  }

  @override
  int get hashCode => Object.hashAll([id, releaseDate]);
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  var ageMapBefor2010 = <int>{};
  mapBefore2010.forEach((key, value) {
    for (var country in value) {
      for (var year in country.machineries) {
        ageMapBefor2010.add(DateTime.now().year - year.releaseDate.year);
      }
    }
  });

  var ageMapAfter2010 = <int>{};
  mapAfter2010.forEach((key, value) {
    for (final country in value) {
      for (final date in country.machineries) {
        ageMapAfter2010.add(DateTime.now().year - date.releaseDate.year);
      }
    }
  });

  final ageAllMachineriesSet = ageMapBefor2010.union(ageMapAfter2010);
  var ageAllMachineriesList = ageAllMachineriesSet.toList();
  ageAllMachineriesList.sort();
  var totalAgeAllMachineries =
      ageAllMachineriesList.reduce((total, element) => total += element);
  var averageAgeAllMachineries =
      totalAgeAllMachineries ~/ ageAllMachineriesList.length;
  print('Средний возраст всей техники: $averageAgeAllMachineries');

  var oldestMachineriestList =
      ageAllMachineriesList.sublist(ageAllMachineriesList.length ~/ 2);
  var totalAgeOldestMachineries =
      oldestMachineriestList.reduce((total, element) => total += element);
  var averageAgeOldestMachineries =
      totalAgeOldestMachineries ~/ oldestMachineriestList.length;
  print('Средний возраст самой старой техники: $averageAgeOldestMachineries');
}
