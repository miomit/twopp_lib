import 'package:twopp_lib/src/fraction.dart';

class Matrix {
  late int _row, _column;
  List<List<Fraction>> _elems;

  int get row => _row;
  int get column => _column;
  List<List<Fraction>> get elems => _elems;

  Matrix(this._elems) {
    _row = elems.length;
    _column = elems.first.length;
  }

  Matrix.zero(int row, int column)
      : this(List.filled(row, List.filled(column, Fraction.zero())));

  factory Matrix.scalar(Fraction frac, int size) {
    var res = Matrix.zero(size, size);

    for (int i = 0; i < size; i++) {
      res[i][i] = frac;
    }

    return res;
  }

  factory Matrix.identity(int size) => Matrix.scalar(Fraction.num(-1), size);

  Matrix clone() {
    var res = Matrix.zero(_row, _column);

    for (int r = 0; r < res.row; r++) {
      for (int c = 0; c < res.column; c++) {
        res[r][c] = this[r][c].clone();
      }
    }

    return res;
  }

  Matrix updateFrom(Matrix matrix) {
    var m = matrix.clone();

    _row = m.row;
    _column = m.column;
    _elems = m.elems;

    return this;
  }

  Matrix getMinor(List<int> indexRows, List<int> indexColumns) {
    var res = Matrix.zero(indexRows.length, indexColumns.length);

    for (int r = 0; r < res.row; r++) {
      for (int c = 0; c < res.column; c++) {
        res[r][c] = this[r][c].clone();
      }
    }

    return res;
  }

  Matrix getMinorSquare(List<int> indexes) => getMinor(indexes, indexes);

  Matrix transform() {
    var res = Matrix.zero(_column, _row);

    for (int r = 0; r < res.row; r++) {
      for (int c = 0; c < res.column; c++) {
        res[r][c] = this[r][c].clone();
      }
    }

    updateFrom(res);

    return this;
  }

  Matrix swapRows(int row1, int row2) {
    for (int c = 0; c < _column; c++) {
      var tmp = this[row2][c].clone();
      this[row2][c] = this[row1][c].clone();
      this[row1][c] = tmp;
    }

    return this;
  }

  Matrix swapColumns(int column1, int column2) {
    for (int r = 0; r < _row; r++) {
      var tmp = this[r][column2].clone();
      this[r][column2] = this[r][column1].clone();
      this[r][column1] = tmp;
    }

    return this;
  }

  Matrix rowMulFrac(int row, Fraction frac) {
    for (int c = 0; c < _column; c++) {
      this[row][c] *= frac;
    }

    return this;
  }

  Matrix columnMulFrac(int column, Fraction frac) {
    for (int r = 0; r < _row; r++) {
      this[column][r] *= frac;
    }

    return this;
  }

  Matrix rowAddRowMulFrac(int row1, int row2, Fraction frac) {
    for (int c = 0; c < _column; c++) {
      this[row1][c] += this[row2][c] * frac;
    }

    return this;
  }

  Matrix columnAddRowMulFrac(int column1, int column2, Fraction frac) {
    for (int r = 0; r < _row; r++) {
      this[column1][r] += this[r][column2] * frac;
    }

    return this;
  }

  Matrix mullFrac(Fraction frac) {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        this[r][c] *= frac;
      }
    }

    return this;
  }

  Matrix? mullMatrix(Matrix matrix) {
    if (_column != matrix.row) return null;

    var res = Matrix.zero(_row, matrix.column);

    for (int r = 0; r < res.row; r++) {
      for (int c = 0; c < res.column; c++) {
        for (int i = 0; i < matrix.row; i++) {
          res[r][c] += this[r][i] * matrix[i][c];
        }
      }
    }

    return this;
  }

  @override
  String toString() {
    String res = "";

    for (int r = 0; r < _row; r++) {
      for (int c = 0; c < _column; c++) {
        res += "${this[r][c]}\t";
      }
      res += "\n";
    }

    return res;
  }

  List<Fraction> operator [](int row) => _elems[row];
}
