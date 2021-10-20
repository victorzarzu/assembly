#include <bits/stdc++.h>

using namespace std;
extern "C" void stats(int [], int, int *, int *);

int main()
{
  int lst[] = {1, -2, 3, -4, 5, 7, 9, 11};
  int len = 8;
  int sum, ave;

  stats(lst, len, &sum, &ave);
  cout<<sum<<" "<<ave;
  return 0;
}
