class Fraction {
  int numerator, denominator;

  Fraction(this.numerator, this.denominator) {
    _cut();
  }
  Fraction.num(int num) : this(num, 1);
  Fraction.zero() : this.num(0);

  Fraction clone() => Fraction(numerator, denominator);

  double getResult() => numerator / denominator;

  Fraction _cut() {
    if (denominator < 0) {
      numerator *= -1;
      denominator *= -1;
    }

    int nod = numerator.gcd(denominator);

    if (nod == 1) return this;

    numerator ~/= nod;
    denominator ~/= nod;

    return this;
  }

  Fraction getCut() => Fraction(numerator, denominator)._cut();

  Fraction operator +(Fraction other) => Fraction(
        numerator * other.denominator + other.numerator * denominator,
        denominator * other.denominator,
      );

  Fraction operator -(Fraction other) => Fraction(
        numerator * other.denominator - other.numerator * denominator,
        denominator * other.denominator,
      );

  Fraction operator *(Fraction other) => Fraction(
        numerator * other.numerator,
        denominator * other.denominator,
      );

  Fraction operator /(Fraction other) => Fraction(
        numerator * other.denominator,
        denominator * other.numerator,
      );

  @override
  String toString() {
    if (numerator == 0) return "0";

    if (denominator == 1) {
      return "$numerator";
    } else {
      return "$numerator/$denominator";
    }
  }
}
