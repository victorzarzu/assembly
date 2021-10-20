#include <bits/stdc++.h>
using namespace std;
extern "C" int lstSum(int[], int);
extern "C" int lstAverage(int[], int);

int main()
{
  int lst[] = {1, -2, 3, -4, 5, 7, 9, 11};
  int len = 8;
  cout<<lstSum(lst, len)<<'\n';
  cout<<lstAverage(lst, len);
  
  return 0;
}
