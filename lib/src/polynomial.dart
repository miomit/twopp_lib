import 'dart:math';

import 'package:twopp_lib/src/fraction.dart';

class Polynomial {
  List<Fraction> _coefficients;

  List<Fraction> get coefficients => _coefficients;

  int get count => _coefficients.length;

  Polynomial(this._coefficients) {
    for (int i = _coefficients.length - 1; i >= 0; i--) {
      if (_coefficients[i].numerator != 0) {
        break;
      } else {
        _coefficients.removeAt(i);
      }
    }
  }

  Polynomial.clone(Polynomial p) : this(List.of(p.coefficients));

  Polynomial shiftRight(int shift) {
    var coeff = List.of(_coefficients);

    for (int i = 0; i < shift; i++) {
      coeff.insert(0, Fraction.zero());
    }

    return Polynomial(coeff);
  }

  static (Polynomial, Polynomial) divisionWithRemainder(
      Polynomial polynomial1, Polynomial polynomial2) {
    var coeff = <Fraction>[];
    var remain = Polynomial.clone(polynomial1);

    while (remain.coefficients.length >= polynomial2.coefficients.length) {
      final k = remain.coefficients.last / polynomial2.coefficients.last;

      coeff.add(k);

      remain = remain -
          (polynomial2.shiftRight(remain.coefficients.length -
                  polynomial2.coefficients.length) *
              k);
    }

    return (Polynomial(coeff.reversed.toList()), remain);
  }

  static Polynomial gcd(Polynomial polynomial1, Polynomial polynomial2) {
    if (polynomial2.coefficients.isEmpty) {
      return polynomial1;
    } else {
      return gcd(polynomial2, polynomial1 % polynomial2);
    }
  }

  Polynomial operator +(Polynomial other) {
    var coeff = <Fraction>[];

    for (int i = 0;
        i < max(_coefficients.length, other.coefficients.length);
        i++) {
      coeff.add(Fraction.zero());

      if (i < _coefficients.length) {
        coeff[i] += _coefficients[i];
      }

      if (i < other.coefficients.length) {
        coeff[i] += other.coefficients[i];
      }
    }

    return Polynomial(coeff);
  }

  Polynomial operator -(Polynomial other) => this + other * Fraction.num(-1);

  Polynomial operator *(Fraction frac) {
    var coeff = <Fraction>[];

    for (var elem in _coefficients) {
      coeff.add(elem * frac);
    }

    return Polynomial(coeff);
  }

  Polynomial operator /(Polynomial other) {
    var (res, _) = divisionWithRemainder(this, other);

    return res;
  }

  Polynomial operator %(Polynomial other) {
    var (_, res) = divisionWithRemainder(this, other);

    return res;
  }

  @override
  String toString() {
    var res = "";
    int i = _coefficients.length - 1;
    bool flag = false;

    for (var coefficient in _coefficients.reversed) {
      if (coefficient.numerator != 0) {
        res +=
            "${(coefficient.getResult() < 0 ? "- ${(i != 0 && -1 * coefficient.getResult() == 1 ? "" : Fraction.num(-1) * coefficient)}" : (flag ? "+ ${(i != 0 && coefficient.getResult() == 1 ? "" : coefficient)}" : "${(i != 0 && coefficient.getResult() == 1 ? "" : coefficient)}"))}${(i != 0 ? "x${(i == 1 ? "" : "^$i")}" : "")} ";
        flag = true;
      }
      i--;
    }

    return res;
  }
}
