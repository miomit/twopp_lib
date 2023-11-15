import 'dart:math';

class Complex {
  double re, im;

  Complex(this.re, this.im);
  Complex.real(double re) : this(re, 0);
  Complex.initWithModuleAndArg(double module, double arg)
      : this(cos(arg) * module, sin(arg) * module);

  double getModule() => sqrt(pow(re, 2) + pow(im, 2));

  double getArg() {
    var res = atan(im / re);

    if (re < 0 && im > 0) res += pi;
    if (re < 0 && im < 0) res -= pi;

    if (re == 0 && im > 0) res = pi / 2;
    if (re == 0 && im < 0) res = 3 * pi / 2;

    return res;
  }

  Complex root(double degree, double k) {
    final z = pow(getModule(), 1 / degree).toDouble();

    final f = (getArg() + 2 * pi * k) / degree;

    return Complex.initWithModuleAndArg(z, f);
  }

  Complex operator +(Complex other) => Complex(re + other.re, im + other.im);
  Complex operator -(Complex other) => Complex(re - other.re, im - other.im);

  Complex operator *(Complex other) => Complex(
        re * other.re - im * other.im,
        re * other.im + im * other.re,
      );

  Complex operator ~() => Complex(re, -im);

  Complex operator ^(double n) {
    final z = pow(getModule(), n);

    final f = getArg();

    return Complex(z * cos(n * f), z * sin(n * f));
  }

  @override
  String toString() {
    var res = "";
    if (re != 0) res += "$re";
    if (im != 0) {
      if (im > 0) res += "+";
      if (im != 1) res += "$im";
      res += "i";
    }
    return res;
  }
}
