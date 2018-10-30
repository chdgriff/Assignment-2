// stringset.cpp
//
// Created by Christopher Griffis on 10/12/18.

#include "stringset.h"

using namespace std;

unordered_set<string> set;

// Inserts a string or returns first instance of it
const string* intern_stringset (const char* string){
  auto handle = set.insert(string);
  return &*handle.first;
}


// Dumps infor from string set
void dump_stringset (FILE* file) {
  unordered_set<string>::hasher hash_fn;
  
  size_t maxBucketSize = 0;
  for (size_t bucket = 0; bucket < set.bucket_count(); ++bucket) {
    bool needIndex = true;
    size_t currSize = set.bucket_size(bucket);
    
    if (maxBucketSize < currSize) maxBucketSize = currSize;
    
    for (auto itor = set.cbegin(bucket);
         itor != set.cend(bucket); ++itor) {
      if (needIndex) fprintf(file, "hash[%4zu]: ", bucket);
      else fprintf (file, "           %4s   ", "");
      
      needIndex = false;
      const string* str = &*itor;
      fprintf(file, "%22zu %p->\"%s\"\n",
              hash_fn(*str), str, str->c_str());
    }
  }
  fprintf (file, "load_factor = %.3f\n", set.load_factor());
  fprintf (file, "bucket_count = %zu\n", set.bucket_count());
  fprintf (file, "max_bucket_size = %zu\n", maxBucketSize);
}
