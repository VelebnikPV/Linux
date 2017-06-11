//division.cpp : Defines the entry point for the console
// application.
//

#include "stdafx.h"
#include <iostream>
#include <string>

const int BASE = 100000;

struct longNumber {
  int pre = 0;
  int su = 0;
  int zap = 0;
};

longNumber increase(longNumber a);

longNumber create_ln(std::string a, std::string b) {

  int zap = 0;

  while (b[zap] == '0' && (zap < 5)) {
    zap++;
  }

  while (b.size() != 5) {
    b += '0';
  }

  return longNumber{std::stoi(a), std::stoi(b), zap};
}

void print(longNumber a) {
  std::cout << a.pre << ".";
  while (a.zap--) {
    std::cout << "0";
  }

  std::cout << a.su << std::endl;
}

bool ge(longNumber a, longNumber b) {
  if (a.pre > b.pre) {
    return true;
  } else if (a.pre == b.pre) {
    return a.su >= b.su;
  }
  return false;
}

longNumber sub(longNumber a, longNumber b);
longNumber division(longNumber a, longNumber b) {
  longNumber res;
  int ecz = 5;

  while (ge(a, b)) {
    a = sub(a, b);
    res.pre++;
  }

  while (ecz) {
    int times = 0;
    a = increase(a);
    while (ge(a, b)) {
      a = sub(a, b);
      times++;
    }
    res.su += times;
    res.su *= 10;
    ecz--;
  }

  res.su /= 10;
  return res;
}

longNumber increase(longNumber a) {
  a.pre = a.pre * 10;
  a.su *= 10;

  if (a.zap == 0) {
    a.pre += a.su / BASE;
    a.su %= BASE;
  } else {
    a.zap--;
  }

  return a;
}

longNumber sub(longNumber a, longNumber b) {
  if (b.su > a.su) {
    a.pre--;
    a.su += BASE;
  }

  a.su = a.su - b.su;
  a.pre = a.pre - b.pre;

  return a;
}

int main() {

  longNumber a = create_ln("0", "00103");
  longNumber b = create_ln("0", "00007");

  longNumber c = division(a, b);

  print(a);
  print(b);
  print(c);

  return 0;
}
