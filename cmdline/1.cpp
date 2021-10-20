#include <bits/stdc++.h>

using namespace std;

void scrie(char* par)
{
  cout<<par<<'\n';
}

int main(int argc, char* argv[])
{
  cout<<argc<<'\n';
  cout<<"Program name: "<<argv[0]<<'\n';
  for(int i = 0;i < argc;++i)
    scrie(argv[i]);
  return 0;
} 
