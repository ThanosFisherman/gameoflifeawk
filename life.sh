    #!/bin/sh
    #game of life 
	# by Thanos Psaridis
	#AM: 1820
	#e-mail: psaridis@gmail.com
	
    awk -v runs=${1:-10} -v speed=${2:-0.5} ' #optional parameters ean o xristis de dosei arithmo epanalipsewn kai taxytita xrisimopoiountai to 10 kai 0.5 apo default	
	BEGIN { DEAD = "0"; ALIVE = "1"; 
	printf("\033[1;35;44m --------------------------------\033[1;40m\n");
	printf("\033[1;35;44m |                              |\033[1;40m\n");
	printf("\033[1;35;44m | welcome to the game of life  |\033[1;40m\n");
	printf("\033[1;35;44m |                              |\033[1;40m\n")
	printf("\033[1;35;44m |               by             |\033[1;40m\n");
	printf("\033[1;35;44m |                              |\033[1;40m\n")
	printf("\033[1;35;44m | \033[1;32m      Thanos Psaridis        \033[1;35m|\033[1;40m\n");
	printf("\033[1;35;44m |                              |\033[1;40m\n");
	printf("\033[1;35;44m --------------------------------\033[1;40m\n");
	system("sleep 5");
	}
	
      function checkAlive(cell, neighbor) {
		if ( (neighbor < 1) || (neighbor > size) ) return 0;         # elenxos oriwn panw kai katw apo ton pinaka
        if ( ((cell%cols) == 1) && ((neighbor%cols) == 0) ) return 0; # elenxos oriwn aristera tou pinaka
        if ( ((cell%cols) == 0) && ((neighbor%cols) == 1) ) return 0; # elenxo oriwn deksia tou pinaka

		if ( substr(data, neighbor, 1)  == ALIVE ) return 1; #epestrepse 1 ean to geitoniko keli einai en zwh
		
		return 0;
  
      }

      # plithos apo geitonika kelia pou einai en zwh kathe keli sinorevei me 8
      function countAlive(cell) {
        count = checkAlive(cell, cell-cols-1) + checkAlive(cell, cell-cols) + checkAlive(cell, cell-cols+1);
        count += checkAlive(cell, cell-1) + checkAlive(cell, cell+1);
        count += checkAlive(cell, cell+cols-1) + checkAlive(cell, cell+cols) + checkAlive(cell, cell+cols+1);

        return count;
      }
      
	  # emfanisi pinaka me xrwmata
      function display(data) {
        for (i=1; i<=size; i++) {
		
		if ( substr(data, i, 1) == ALIVE )
			printf("\033[1;31;40m%c", substr(data, i, 1));
		else
			printf("\033[1;30;40m%c", substr(data, i, 1));
		
		if ( i%cols == 0 )
			printf("\n");
		}
		
      }
    {
      # diavazei grammi-grammi apo to arxeio pou exei dothei
      lines++;              # metritis grammwn arxeiou (tha xrisimopoiithei gia metrame tis grammes tou pinaka)
      data=data""$0;        # topothetei to periexomeno pou diavazei apo to arxeio stin metavliti data kathe fora
    } END {

      printf("\033[2J");  # katharismos othonis xrisimopoiontas ANSI escape sequence

      cols=int(length(data)/lines); #ypologismos stylwn tou pinaka
      if ( (length(data)/lines) != cols) #elenxos gia to an exoun eisaxthei lanthasmena dedomena
	  { 
		printf("lathos dedomena sto arxeio\n"); #ean to arxeio einai lathos tote eksodos
		exit(1); 
	  }
      size = cols*lines; #megethos pinaka

      for (run=1; run<=runs; run++) {
        printf("\033[H\033[1;33;40mGeneration %d:\033[K", run);
		printf("\n");
        display(data);
		
        newdata="";
        for (cell=1; cell<=size; cell++) {
		
          count = countAlive(cell);           # arithmos geitonikwn keliwn pou einai en zwh trigiro apo to kell cell
		  if ( count == 2)		#ean einai 2 zwntana geitonika kelia
		  {
				oldstate = substr(data, cell, 1); # pare tin palia katastasi tou keliou
				newstate = oldstate; # kai valtin stin metavliti newstate ousiastika den kanei kamia allagi
		  }
		  else if ( count == 3 ) #ean einai 3 zwntana geitonika kelia
				newstate = ALIVE; #tote dimiourgeitai zwh stin kainouria katastasi
		  else
				newstate = DEAD;                  # se kathe alli periptwsi i kainouria katastasi einai DEAD
		  
          newdata=newdata""newstate;  #vale tin kanouria katastasi sto newdata
        }

        data = newdata;  #vale tin newdata pisw sti metavliti data
        if ( speed > 0) system(sprintf("sleep %.1f", speed));  #steile stin konsola tin entoli sleep
      }

      
    }' #telos AWK
