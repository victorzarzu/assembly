#include <bits/stdc++.h>

using namespace std;
extern "C" int lstSum(int[], int);
extern "C" int lstAverage(int[], int);
extern "C" void print(int, char *);

char str[100];

int main()
{
  int lst[] = {1, -2, 3, -4, 5, 7, 9, 11};
  int len = 8;
  int sum = lstSum(lst, len);
  int avg = lstAverage(lst, len);
  
  print(sum, str);
  print(avg, str);
  return 0;
}
