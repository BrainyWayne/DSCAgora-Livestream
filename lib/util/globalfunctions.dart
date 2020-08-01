import 'dart:math';

int randomNumber(int min, int max){
  Random random = new Random();
  int randomNumber = random.nextInt(max) + min;
  return randomNumber;
}