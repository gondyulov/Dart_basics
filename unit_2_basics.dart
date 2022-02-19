import 'dart:math';

enum Numbers {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine
}

class DelimetersMethods {
  // 1 Реализуйте методы вычисления НОД

  int getNOD(int x, int y) {
    while (x != 0 && y != 0) {
      if (x > y) {
        x %= y;
      } else {
        y %= x;
      }
    }
    return x+y;
  }

  // и НОК целых чисел.

  int getNOK(int x, int y) {
    return x * y ~/ getNOD(x, y);
  }

  // Реализуйте метод, который разбивает число на простые множители и возвращает их.

  String getPM(int x) {
    int i = 2;
    List<String> results = [];
    while (x > 1) {
      while (x % i != 0) {
        i++;
      }
      results.add(i.toString());
      x = (x / i).round();
      i = 2;
    }
    return results.join(' * ');
  }
}

class ConvertersMethods {
  // 2 Реализуйте методы для преобразования целых чисел из десятичной системы в двоичную

  String decToBin(int x) {
    String bin = '';
    while (x > 0) {
      if (x % 2 == 1) {
        x = (x - 1) ~/ 2;
        bin = '1' + bin;
      }
      else {
        x = x ~/ 2;
        bin = '0' + bin;
      }
    }
    return bin;
  }

  // и обратно.

  int binToDec(String s) {
    int result = 0;
    int counter = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      result += int.parse(s[i]) * pow(2, counter).toInt();
      counter += 1;
    }
    return result;
  }
}

class CollectionsMethods {
  // 3 Реализуйте метод, который принимает строку слов, разделённых пробелами.
  //   Задача — найти в данной строке числа и вернуть коллекцию num этих чисел.

  List<num> GetNumbers(String x) {
    List<num> result = [];
    x.split(' ').forEach((element) {
      if (num.tryParse(element) != null) {
        result.add(num.parse(element));
      }
    });
    return result;
  }

  // 4 Есть коллекция слов. Реализуйте метод, возвращающий Map.
  // Данный Map должен соотносить слово и количество его вхождений в данную коллекцию.

  Map GetWordsCounts(List<String> ls) {
    Map result = {};
    ls.forEach((element) {
      if (result.containsKey(element)) {
        result[element] += 1;
      } else {
        result[element] = 1;
      }
    });
    return result;
  }

  // 5 Есть коллекция строк вида ‘one, two, three, cat, dog’ или любого другого.
  // Реализуйте метод, возвращающий цифры без повторений, которые встречаются в данной строке.
  // Однако цифры встречаются в виде английских слов от zero до nine.
  // Например, в результате строки ‘one, two, zero, zero’ мы получим следующий результат: [1, 2, 0].
  // Если в строке есть слова, не являющиеся цифрами от 0 до 9, пропускайте их.

  Set GetDigitsWithoutDuplicates(List<String> ls) {
    Set result = {};
    ls.forEach((element) {
      Numbers.values.forEach((number) {
        if ('Numbers.${element}' == number.toString()) {
          result.add(number.index);
        }
      });
    });
    return result;
  }
}

// 6 Реализуйте класс Point, который описывает точку в трёхмерном пространстве. У данного класса реализуйте
// метод distanceTo(Point another), который возвращает расстояние от данной точки до точки в параметре.
// По желанию можете реализовать метод, принимающий три точки в трёхмерном пространстве и возвращающий площадь треугольника,
// который образуют данные точки. Реализуйте factory-конструкторы для данного класса, возвращающие начало координат, и ещё
// несколько на своё усмотрение (например, конструктор, возвращающий точку с координатами [1,1,1], которая определяет единичный вектор).

class Point {
  final double x;
  final double y;
  final double z;

  Point(this.x, this.y, this.z);

  factory Point.zero() {
    return Point(0, 0, 0);
  }

  double distanceTo(Point another) {
    num res = pow((x - another.x), 2) + pow((y - another.y), 2) + pow((z - another.z), 2);
    return sqrt(res);
  }
}

// 7 Реализуйте метод, который вычисляет корень любой заданной степени из числа.
// Реализуйте данный метод как extension-метод для num.
// Запрещается использовать методы math.
// В случае когда значение вернуть невозможно, необходимо бросать исключение с описанием ошибки.

extension numMethods on num {
  num powN(int n) {
    num result = 1;
    for (int i = 0; i < n; i++) {
      result *= this;
    }
    return result;
  }

  num sqrtN(int n) {
    if (this <= 0) {
      throw ArgumentError('Значение $this должно быть положительным!');
    }
    if (n <= 0) {
      throw ArgumentError('Корень $n не может быть отрицательным!');
    }

    try {
      num res = this / n; // Начальное предположение
      num eps = 0.00001; // Точность
      num resNext;
      while (true) {
        resNext = (1 / n) * ((n - 1) * res + this / res.powN(n - 1));
        if (resNext - res < eps && resNext - res > -eps) {
          break;
        }
        res = resNext;
      }
      return resNext;
    } catch(e) {
      print(e.toString());
      return -1;
    }
  }
}

// Создайте класс User, у которого есть поле email.
// Реализуйте два наследника данного класса AdminUser и GeneralUser.
// Реализуйте mixin над классом User, у которого будет метод getMailSystem, который возвращает значение из email, которое находится после @.
// Например, если email пользователя user@mail.ru, то данный метод вернёт mail.ru.
// Используйте данный миксин на AdminUser.
// Далее реализуйте класс UserManager<T extends User>, у которого будет храниться список пользователей и будут
// методы добавления или удаления их. Также в UserManager реализуйте метод, который выведет почту всех пользователей,
// однако если пользователь admin, будет выведено значение после @. Проверьте реализованные методы на практике.

class User {
  final String email;
  User(this.email);
}

class AdminUser extends User with UserMethods {
  AdminUser(String email) : super(email);
}

class GeneralUser extends User with UserMethods {
  GeneralUser(String email) : super(email);
}

class UserManager extends User {
  UserManager(String email) : super(email);
  List<User> userList = [];

  void addUser(User u) {
    userList.add(u);
  }

  void removeUser(int index) {
    userList.removeAt(index);
  }

  void printMails() {
    userList.forEach((user) {
      if (user.runtimeType == AdminUser)
        print('   ${user.runtimeType} ${(user as AdminUser).getMailSystem}');
      else
        print('   ${user.runtimeType} ${user.email}');
    });
  }
}

mixin UserMethods on User {
  String get getMailSystem => email.split('@')[1];
}

// 9 (Усложнённое). Реализуйте метод, который вычисляет значение определённого интеграла Римана в заданных значениях
// и с заданной точностью разбиения. По возможности учтите случаи, когда функция имеет точки разрыва.
// Реализованный метод должен принимать функцию, точки x1 и x2, точность разбиения.

class MathMethods {
  num f(num x) {
    return 1 + x/2;
  }

  num rimanCalc(Function f, num x1, num x2, int e) {
    num result = 0;
    num tmp;
    num de = (x2 - x1) / e;
    for (int i = 0; i < e; i++) {
      tmp = f(x1 + de/2);
      result += (tmp * de).abs();
      x1 += de;
    }
    return result;
  }
}

void main() {
  DelimetersMethods  dlm = DelimetersMethods();

  print(1);
  int x = 45;
  int y = 60;
  print('   НОД $x и $y: ${dlm.getNOD(x, y)}');
  print('   НОК $x и $y: ${dlm.getNOK(x, y)}');
  print('   Простые множители числа $x: ${dlm.getPM(x)}');

  ConvertersMethods  cnv = ConvertersMethods();

  print(2);
  print('   $x в двоичном виде: ${cnv.decToBin(x)} . Проверка: ${x.toRadixString(2)}');
  print('   ${cnv.decToBin(y)} в десятичном виде: ${cnv.binToDec(cnv.decToBin(y))} . Проверка: ${int.parse(cnv.decToBin(y), radix: 2)}');

  CollectionsMethods clc = CollectionsMethods();

  print(3);
  String sample = "test 12 asd qwerty 23.34 4 flutter";
  print('   Numbers в строке \'$sample\' : ${clc.GetNumbers(sample)}');

  print(4);
  List<String> words = ['test', 'asd', 'asd', 'test', 'a', 'b', 'a', 'test', 'asd', 'test'];
  print('   Map из $words : ${clc.GetWordsCounts(words)}');

  print(5);
  words = ['one', 'two', 'three', 'cat', 'dog', 'seven', 'zero', 'one', 'home'];
  print('   Цифры в $words : ${clc.GetDigitsWithoutDuplicates(words)}');

  Point p = Point(5, 4, 4);

  print(6);
  print('   Дистанция от нуля до (${p.x},${p.y},${p.z}) : ${Point.zero().distanceTo(p)}');

  print(7);
  x = 81;
  y = 4;
  print('   Корень $y степени от $x : ${x.sqrtN(y)}');

  UserManager um = UserManager('test@manager.net');

  print(8);
  print('   ${AdminUser('test@admin.net').getMailSystem}');
  um.addUser(AdminUser('a1@admin1.com'));
  um.addUser(AdminUser('a2@admin2.com'));
  um.addUser(AdminUser('a3@admin3.com'));
  um.addUser(GeneralUser('g1@general1.com'));
  um.addUser(GeneralUser('g2@general2.com'));
  um.removeUser(2);
  um.printMails();

  MathMethods mm = MathMethods();

  print(9);
  int x1 = 0; int x2 = 10; int e = 50;
  print('   Площадь фигуры образованной функцией f(x) = 1 + x/2 на интервале от $x1 до $x2 с '
        'точностью $e(итераций) равна ${mm.rimanCalc(mm.f, x1, x2, e)}');
}