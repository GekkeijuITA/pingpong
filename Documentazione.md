# Relazione progetto pingpong server

#### Componenti: Lorenzo Vaccarecci, Daniele Sacco, Samuele Barrago


## Documentazione Pong Server

Il Pong Server è un'applicazione che risponde ai messaggi inviati dai client Ping, sia tramite protocollo TCP che UDP. Il server è progettato per accettare connessioni multiple da client Ping e rispondere alle richieste in modo efficiente.
Certo, ecco come potrebbe essere aggiunta la sezione "Ulteriori Errori" alla vostra relazione:

## Errori e Soluzioni

Durante lo sviluppo del Pong Server, abbiamo riscontrato e risolto diversi errori. Di seguito sono riportati alcuni esempi di come abbiamo modificato il codice per risolvere questi problemi.

### Invio dei pacchetti
- **Problema:** L'invio di messaggi attraverso il socket in modalità bloccante non riusciva a inviare tutti i dati.
- **Soluzione:** Abbiamo sostituito la funzione `send` con la nostra funzione personalizzata `blocking_write_all`.

### Scrittura msg_no alla fine del buffer
- **Problema:** La scrittura del numero del messaggio all'inizio del buffer del messaggio non funzionava correttamente.
- **Soluzione:** Abbiamo utilizzato la funzione `sprintf` per formattare correttamente la stringa.

### Ricevimento pacchetti dal socket 
- **Problema:** La ricezione di risposte attraverso il socket in modalità non bloccante con timeout presentava problemi.
- **Soluzione:** Abbiamo implementato un ciclo for per ricevere i dati in più passaggi, invece di cercare di ricevere tutti i dati in una sola volta.

## Debug
Durante lo sviluppo del server Pong, abbiamo adottato un approccio passo-passo per il debug. Inizialmente, abbiamo testato il server con `gc_*ping`, poi con i nostri ping. Abbiamo utilizzato la modalità debug del Makefile per individuare e risolvere gli errori. Questo ci ha permesso di migliorare il nostro server in modo efficace.


## Utilizzo

Il Pong Server deve essere eseguito con un argomento che specifica la porta su cui ascoltare. Ad esempio:

```bash
./pong_server 8080
```
Il server rimarrà in ascolto su questa porta, gestirà le connessioni dei client Ping e risponderà alle loro richieste.
```