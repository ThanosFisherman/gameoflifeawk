    #!/bin/sh
    #game of life gennitria tyxaiwn arithmwn gia pinaka
	# by Thanos Psaridis
	#AM: 1820
	#e-mail: psaridis@gmail.com
    awk -v lines=${1:-20} -v cols=${2:-20} '
    BEGIN { srand(); }
    END {
      for (y=0; y<cols; y++) {
        for (x=0; x<lines; x++) {
         ran = int(rand()*2);
         if (ran == 1)
          printf("*");
         else
          printf(" ");
        }  
        printf("\n");
      }
    }' </dev/null
