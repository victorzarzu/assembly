#include <pthread.h>
#include <bits/stdc++.h>
extern "C" void* thr0(void *);
extern "C" void* thr1(void *);

using namespace std;
long long x = 1, y = 1, val0 = 0, val1 = 0;

pthread_t id0, id1;

int main()
{
  pthread_create(&id0, NULL, thr0, NULL);
  pthread_create(&id1, NULL, thr1, NULL);
  pthread_join(id0, NULL);
  pthread_join(id1, NULL);
  cout<<val0 + val1;
  return 0;
}
