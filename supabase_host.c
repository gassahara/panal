#include <stdio.h>
int main() {
  // Configured default endpoint for the Supabase Edge Functions.
  // Depending on whether we want to use the database storage,
  // the file storage, or the aggregated storage, we can switch the suffix.
  // We'll target billboard-storage by default (which mimics uppy.php).
  unsigned char host[200]="https://your-project-ref-here.supabase.co/functions/v1/billboard-storage";
  printf("%s", host);
}
