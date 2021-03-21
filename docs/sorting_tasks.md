# Auswertungsmöglichkeiten von Sortieraufgaben
*Autor: Arne Bewersdorff*

Zur Erhebung von Fachwissen von Lernenden existiert eine Reihe von Testinstrumenten für die unterschiedlichen Disziplinen. Im Wesentlichen werden dabei offene oder gebundene Antwortformate eingesetzt: Bei den offenen Antwortformaten ist der Proband aufgefordert mit eigenen Worten, einer Zeichnung o. ä. zu antworten. Gebundene Antwortformate geben Antwortoptionen vor. Bei der gebundenen Beantwortung werden festgelegte Antwortkategorien vorgegeben, es gibt keinen Freiraum für eigene Antworten. Sortieraufgaben (Umordnungsaufgaben) gehören zu den gebundenen Antwortformaten (vgl. @Buehner).

Beispiele für den Einsatz solcher Sortieraufgaben sind vielfältig: Im Rahmen eines Fachwissenstests können die Probanden etwa aufgefordert werden die einzelnen Prozesse der Mitose in die korrekte Reihenfolge zu bringen. Soll das Prozesswissen zum Experimentieren (didaktisch reduziert) erfasst werden, bietet es sich an, die einzelnen Teilprozesse des deduktiven Experiments in die richtige Reihenfolge bringen zu lassen (vgl. @Backes). Ähnlich bei @Friege wobei Schritte im Problemlöseprozess soriert werden müssen.

Eine weitere Möglichkeit stellt das Sortieren von Strukturen ihrer Größe nach in einem Fachwissenstest dar.

Doch wie können die mittels eines solchen Tests gewonnenen Daten ausgewertet werden? Eine dichotome Auswertung nach ,richtig sortiert'/,falsch sortiert' liegt auf der Hand, jedoch ist diese Methode nicht besonders sensibel bezüglich des Fehlergrades:

1.	Bei einer Sortierung, bei welcher der Proband nur zwei benachbarte Teilprozesse vertauscht hat, wird der Fehler als ebenso schwerwiegend gewertet als wenn der Start- und Endprozess vertauscht werden.

2.	Eine Sortierung, bei welcher der Proband nur zwei Teilprozesse vertauscht hat wird als ebenso schwerwiegend gewertet, als wenn er mehrere (alle) Teilprozesse falsch zugeordnet hat.

Es gelten bei Sortieraufgaben also im Wesentlichen zwei Faktoren, welche auf den Grad des Fehlers einwirken: Die Anzahl der falsch sortierten Teilprozesse und der Abstand der falsch sortierten Teilprozesse zueinander. Im Folgenden sollen verschiedene Algorithmen zur Bestimmung des Fehlergrades, sowie ihre Implementation in R, vorgestellt werden.

Anstatt der hier im Folgenden vorgestellten strukturellen (mathematischen) Maße können Sortieraufgaben auch nach inhaltlichen Kriterien ausgewertet werden, siehe hierzu beispielhaft @ZFDN.

## Der Datensatz
Aufgrund der fehlenden Verfügbarkeit eines bereits existierenden Datensatzes soll im Folgenden auf einen künstlich erzeugten, geeigneten Datensatz zurückgegriffen werden.
Die Aufgabe zu diesem Datensatz lautet: 

*Ordnen Sie die folgenden Strukturen nach ihrer Größe (kleinste zuerst).*

*1) DNA-Doppelhelix 2) Ribosom 3) AIDS-Virus 4) Bakterien 5) rote Blutkörperchen 6) menschliche Leberzelle 7) menschliche Eizelle 8) große Amöbe* (aus @Linder)
<!---
<center><img src="Datensatz.png" alt="Datensatz" width="350"> </center>
Abbildung 1: Beispiel für Sortieraufgabe
-->

Der Datensatz ist im Anhang und unter INSERT_LINK_TO_XLS verfügbar. Aus Gründen der Nachvollziehbarkeit lautet die korrekte Sortierung 1) 2) 3) 4) 5) 6) 7) 8).

In R wird der Datensatz folgendermaßen eingelesen:

```r
#library(xlsx)
sorting <- read.csv("Dataset_Sorting_Task.csv") # Daten einlesen
head(sorting) #ersten Einträge des Datensatzes ausgeben
Fehlergrad <- sorting #Matrix erstellen um den Fehlergrad für jede ID zu erfassen
```
Der ,Fehlergrad' soll im Folgenden immer den Hinweis auf die Schwere des Fehlers geben und ist abhängig vom verwendeten Algorithmus.




|     ID    |     Sortierung                                              |     ‚Fehlertyp‘                             |
|-----------|-------------------------------------------------------------|---------------------------------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     korrekt                                 |
|     2     |     1<span style='color: red;'>32</span>45678                         |     Nachbarpositionen   vertauscht          |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     Zwei Positionen vertauscht              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     Zwei Positionen vertauscht              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     Randpositionen vertauscht               |
|     6     |     <span style='color: red;'>231</span>45567                         |     Eine Position falsch eingeordnet        |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     Zwei Nachbarn vertauscht                |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     Zwei Positionen falsch   eingeordnet    |
|     9     |     <span style='color: red;'>23456781</span>                         |     Jeweils um 1 verschoben                 |
|     10    |     <span style='color: red;'>87654321</span>                         |     Rückwärts                               |

## Die Auswertungsmöglichkeiten
In den folgenden Teilkapiteln werden die unterschiedlichen Auswertungsmöglichkeiten vorgestellt.

### Dichotom: Sortierung ist richtig oder falsch
Die einfachste Möglichkeit der Auswertung von Sortieraufgaben ist zu entscheiden, ob die Sortierung korrekt oder nicht korrekt vorgenommen wurde. Diese Art der Auswertung ist etwa sinnvoll, wenn allein die absolute Anzahl bzw. der Anteil der korrekten Antworten von Interesse ist.
In R ist diese Auswertung schnell zu implementieren:


```r
#Schleife über alle ID
for(i in 1:length(sorting$ID)){
  if(sorting$Sorting[i] == 1234567){
    Fehlergrad$Sorting[i] <- 0
  }
  else {
    Fehlergrad$Sorting[i] <- 1
  }
}
```
Die Ausgabe bei Verwendung des Beispieldatensatzes lautet (zur besseren Lesbarkeit wurde die Ausgabe stets in der Formatierung aufbereitet):

|     ID    |     Sortierung                                              |     Fehlergrad     |
|-----------|-------------------------------------------------------------|--------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     0              |
|     2     |     1<span style='color: red;'>32</span>45678                         |     1              |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     1              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     1              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     1              |
|     6     |     <span style='color: red;'>231</span>45567                         |     1              |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     1              |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     1              |
|     9     |     <span style='color: red;'>23456781</span>                         |     1              |
|     10    |     <span style='color: red;'>87654321</span>                         |     1              |


Wenn die Sortierung korrekt angegeben wird beträgt der Fehlergrad 0, alle anderen Sortierungen – unabhängig von der Schwere des Fehlers – werden undifferenziert als falsch (Fehlergrad 1) gewertet. Eine Differenzierung des Fehlergrades findet also nicht statt. 



### Summe der korrekten oder falschen Positionen
Differenziertere Ergebnisse liefert die Wertung der Anzahl der korrekten oder - invertiert - der falschen Positionen in der Sortierung. Es werden die einzelnen Positionen der Sortierung durchlaufen und für jede Position wird geprüft, ob diese korrekt (bzw. falsch) ist. Eine Implementation in R kann folgendermaßen umgesetzt werden:


```r
for(i in 1:length(sorting$ID)){
  #die Zahlenkette wird aufgetrennt und als Vekor einzelner Ziffern in hold abgespeichert
  hold <- as.numeric(strsplit(as.character(sorting$Sorting[i]), "")[[1]])
  
  Fehlergrad$Sorting[i] <- sum(hold != c(1,2,3,4,5,6,7))
}
```
Die Ausgabe des Beispieldatensatzes ist:

|     ID    |     Sortierung                                              |     Fehlergrad     |
|-----------|-------------------------------------------------------------|--------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     0              |
|     2     |     1<span style='color: red;'>32</span>45678                         |     2              |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     2              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     2              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     2              |
|     6     |     <span style='color: red;'>231</span>45567                         |     3              |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     4              |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     4              |
|     9     |     <span style='color: red;'>23456781</span>                         |     8              |
|     10    |     <span style='color: red;'>87654321</span>                         |     8              |

Mit dieser Art der Auswertung können bereits unterschiedliche Fehlergrade bestimmt werden, jedoch sind die einzelnen Fehler nicht nach Distanz gewichtet, so wiegt das Vertauschen benachbarter Positionen bei dieser Auswertungsmethode ebenso schwer wie das intuitiv ungleich problematischere Vertauschen der Anfangs- und Endposition der Sortierung.
Im Fehlergrad wird unterschieden, ob allein zwei Positionen (ID 2-5) oder mehrere (bzw. alle) Positionen vertauscht angegeben wurden (ID 6-10).

### Spearman-Korrelation
Die Rangkorrelationsanalyse nach Spearman ist ein Verfahren zur Berechnung eines Korrelationskoeffizienten welches auf
den Rängen der Variablen basiert. Der errechnete Korrelationskoeffizient $\rho$, die sogenannte Spearman-Korrelation, ist ein Maß für die Ähnlichkeit zweier Variablen (vgl. @Bortz). Die Berechnung des Korrelationskoeffizienten ist in R über die bereits angelegte Funtion `cor(x,y)` schnell möglich. Es ergibt sich folgender Code:


```r
for(i in 1:length(sorting$ID)){
  #die Zahlenkette wird aufgetrennt und als Vekor einzelner Ziffern in hold abgespeichert
  hold <- as.numeric(strsplit(as.character(sorting$Sorting[i]), "")[[1]])

  Fehlergrad$Sorting[i] <- round(cor(c(1,2,3,4,5,6,7,8), hold, method = "spearman"),2)
}
```
Die Ausgabe bei Anwendung der Rangkorrelation nach Spearman auf die Beispielsortierungen lautet:

|     ID    |     Sortierung                                              |     Fehlergrad        |
|-----------|-------------------------------------------------------------|-----------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     1.00              |
|     2     |     1<span style='color: red;'>32</span>45678                         |     0.98              |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     0.90              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     0.79              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |    -0.17              |
|     6     |     <span style='color: red;'>231</span>45567                         |     0.93              |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     0.95              |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     0.81              |
|     9     |     <span style='color: red;'>23456781</span>                         |     0.33              |
|     10    |     <span style='color: red;'>87654321</span>                         |    -1.00              |

Der Korrelationskoeffizient $\rho$ nimmt Werte zwischen -1 (vollständige Verschiedenheit) und 1 (vollständige Übereinstimmung) an. Sowohl die Distanz einer fehlerhaften Sortierung als auch die Anzahl der Fehler fließt in den Korrelationskoeffizienten (hier als Fehlergrad bezeichnet) ein.

### Levenshtein-Algorithmus
Der Levenshtein-Algorithmus [@Levenshtein] berechnet die minimale Anzahl an Einfügeoperationen, Löschoperationen und Ersetzungen, die benötigt werden um die Eingabe in die korrekte Sortierung zu transformieren.
Der Levenshtein-Algorithmus kann über das Package `stringdist` als Funktion aufgerufen werden. Der Rückgabewert ist die minimale Anzahl der Operationen. In R ergibt sich folgender Code:


```r
library(stringdist)
for(i in 1:length(sorting$ID)){
  Fehlergrad$Sorting[i] <- stringdist('1234567',sorting$Sorting[i],method='lv')
}
```
Die Ausgabe bei Anwendung des Levenstein-Algorithmus auf die Beispielsortierungen lautet:

|     ID    |     Sortierung                                              |     Fehlergrad     |
|-----------|-------------------------------------------------------------|--------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     0              |
|     2     |     1<span style='color: red;'>32</span>45678                         |     2              |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     2              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     2              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     2              |
|     6     |     <span style='color: red;'>231</span>45567                         |     2              |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     4              |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     4              |
|     9     |     <span style='color: red;'>23456781</span>                         |     2              |
|     10    |     <span style='color: red;'>87654321</span>                         |     8              |

Zu erkennen ist, dass die Distanz einer fehlerhaften Sortierung nicht in den Fehlergrad einfließt, die Anzahl der Fehler hingegen, analog zum vorherigen Algorithmus (‚Korrekte Position‘), schon.

### Der Bubblesort-Algorithmus
Der Bubblesort-Algorithmus [@Bubble] ist ein Algorithmus zur Sortierung von Werten aus dem Fachbereich der Informatik. Der Name ‚Bubblesort‘ leitet sich von der den Algorithmus erklärenden Analogie  aufsteigender Kohlensäurebläschen in einem Glas ab. Der Algorithmus vergleicht, beginnend mit dem ersten Wert $x_1$ der zu sortierenden Folge, paarweise benachbarte Werte. Ist der rechte Wert $x_{i+1}$ größer oder gleich dem linken Wert $x_i$ findet keine Tauschoperation statt. Ist der rechte Wert $x_{i+1}$  jedoch kleiner als der linke Wert $x_i$, werden die Positionen der beiden Werte vertauscht. Anschließend bearbeitet der Algorithmus das nächste Datenpaar $(x_{i+1}; x_{i+2})$. Große Werte steigen somit wie große Kohlensäurebläschen an kleineren Werten vorbei.
In R lässt sich der Bubblesort-Algorithmus folgendermaßen implementieren:


```r
sortiere.bubble <- function(x)
{
  if(!is.unsorted(x)){
    return(summe_tauschoperationen = 0) 
    stop("Vektor ist bereits sortiert")
  }
  
  n = length(x)
  v = x
  
  for(j in 1:(n-1))
  {
    for(i in 1:(n-j))
    {
      #wenn der Nachfolger kleiner als der aktuelle Wert, vertausche beide Werte
      if(v[i+1]<v[i])
      {
        t = v[i+1]
        v[i+1] = v[i]
        v[i] = t
        
        summe_tauschoperationen = summe_tauschoperationen + 1
        print(summe_tauschoperationen)
      }
    }
  }
  print(v)
  x = v
  return(summe_tauschoperationen)
}

#Counter setzen
summe_tauschoperationen = 0
#Schleife über alle Pre-Bögen
for(i in 1:length(sorting$ID)){
  hold <- as.numeric(strsplit(as.character(sorting$Sorting[i]), "")[[1]])
  #Algorithmus anwenden
  Fehlergrad$Sorting[i] <- sortiere.bubble(hold)
}
```

Der Beispieldatensatz führt zu folgender Ausgabe:

|     ID    |     Sortierung                                              |     Fehlergrad     |
|-----------|-------------------------------------------------------------|--------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     0              |
|     2     |     1<span style='color: red;'>32</span>45678                         |     1              |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     3              |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     5              |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     13             |
|     6     |     <span style='color: red;'>231</span>45567                         |     2              |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     2              |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     6              |
|     9     |     <span style='color: red;'>23456781</span>                         |     7              |
|     10    |     <span style='color: red;'>87654321</span>                         |     28             |

Durch Zählen der Tauschoperationen ist eine sensible Erfassung des Fehlergrades möglich. So ‚kostet‘ die Korrektur falsch sortierter benachbarter Werte nur eine Tauschoperation. Je weiter jedoch die falsch zugeordneten Werte auseinander liegen, desto mehr Tauschoperationen werden nötig – das Maß für den Fehlergrad steigt. 

### Der Jaro-Algorithmus (Jaro-Distanz)
Die Jaro-Distanz ist definiert als 

$dj=\frac{1}{3}\Bigl(\frac{m}{|s1|} +\frac{m}{|s2|} +\frac{(m-t)}{m}\Bigr)$ mit

$m$ = Anzahl der übereinstimmenden Buchstaben (Ziffern)

$s$ = Länge der Zeichenkette

$t$ = Hälfte der Anzahl der Umstellungen der Buchstaben die nötig sind, damit die Buchstabenketten identisch sind. 

Der Jaro-Algorithmus [@Jaro] kann über das Package stringdist als Funktion aufgerufen werden. Der Rückgabewert ist die minimale Anzahl der Operationen. In R ergibt sich folgender Code:


```r
library(stringdist)
for(i in 1:length(sorting$ID)){
  Fehlergrad$Sorting[i] <- round(stringdist('1234567',sorting$Sorting[i],method='jw', p = 0),2)
}
```

Als Erweiterung der Jaro-Distanz kann auch die Jaro-Winkler-Distanz verwendet werden. Hierzu sei auf die Dokumentation des Packages stringdist verwiesen.
Der Beispieldatensatz führt zu folgender Ausgabe:

|     ID    |     Sortierung                                              |     Fehlergrad     |
|-----------|-------------------------------------------------------------|--------------------|
|     1     |     <span style='color: green;'>12345678</span>                       |     0.00           |
|     2     |     1<span style='color: red;'>32</span>45678                         |     0.04           |
|     3     |     <span style='color: red;'>3</span>2<span style='color: red;'>1</span>45678  |     0.04           |
|     4     |     <span style='color: red;'>4</span>23<span style='color: red;'>1</span>5678  |     0.04           |
|     5     |     <span style='color: red;'>8</span>234567<span style='color: red;'>1</span>  |     0.17           |
|     6     |     <span style='color: red;'>231</span>45567                         |     0.06           |
|     7     |     <span style='color: red;'>21</span>3456<span style='color: red;'>87</span>  |     0.08           |
|     8     |     <span style='color: red;'>321</span>45<span style='color: red;'>876</span>  |     0.08           |
|     9     |     <span style='color: red;'>23456781</span>                         |     0.08           |
|     10    |     <span style='color: red;'>87654321</span>                         |     0.50           |

Der Fehlergrad wird als Wert zwischen 0 (exakte Übereinstimmung) und 1 (totale Verschiedenheit) angegeben. Der Wert 1 kann nur erreicht werden, wenn die einzelnen Ziffern nicht in der korrekten Sortierung vorkommen, etwa wenn Buchstaben statt wie gefordert Zahlen angegeben werden.
Analog zum Bubblesort-Algorithmus nimmt auch hier der Fehlergrad mit zunehmendem Abstand der falsch zugeordneten Positionen zu.

## Vergleich und Diskussion

Zum Vergleich der einzelnen Algorithmen wurde jeweils eine Rangfolge vom niedrigsten zum höchsten Fehlergrad gebildet:



<table class="table table-condensed">
 <thead>
  <tr>
   <th style="text-align:left;"> ID </th>
   <th style="text-align:center;"> Sorting </th>
   <th style="text-align:center;"> dichotom </th>
   <th style="text-align:center;"> kor.Position </th>
   <th style="text-align:center;"> Spearman </th>
   <th style="text-align:center;"> Levenshtein </th>
   <th style="text-align:center;"> Bubblesort </th>
   <th style="text-align:center;"> JaroDist </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:center;"> 12345678 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f2fdff">0</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:center;"> 13245678 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:center;"> 32145678 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86cdd9">4</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #a1d9e3">3</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:center;"> 42315678 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #50b5c7">6</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86cdd9">4</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:center;"> 82345671 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #35a9bd">7</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #35a9bd">7</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:center;"> 23145678 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #6bc1d0">5</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #a1d9e3">3</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #bce5ec">2</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #bce5ec">2</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:center;"> 21345687 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #50b5c7">6</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #bce5ec">2</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #35a9bd">7</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #bce5ec">2</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86cdd9">4</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:center;"> 32145876 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #50b5c7">6</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #6bc1d0">5</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #35a9bd">7</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #6bc1d0">5</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86cdd9">4</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:center;"> 23456781 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #35a9bd">7</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #50b5c7">6</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86cdd9">4</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:center;"> 87654321 </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d7f1f5">1</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #0091ab">9</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
   <td style="text-align:center;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #1a9db4">8</span> </td>
  </tr>
</tbody>
</table>

Deutlich werden zwei Eigenschaften:

1.	Es gibt große Unterschiede bezüglich der Sensibilität des Fehlergrades (vgl. dichotom mit dem Bubblesort- oder Jaro-Algorithmus sowie der Spearman-Korrelation).

2.	Auswertungen über die Dichotomie korrekt/falsch, die Methode korrekte Position sowie den Levenshtein-Algorithmus sind nicht sensibel gegenüber der Distanz einer falschen Sortierung (vgl. jeweils ID 1-5).

Der Zweck der Auswertung sollte stets ihre Methode bestimmen und die Aussage nicht durch beschränkte Auswertungsmethoden limitiert oder sogar verzerrt werden. Wie gezeigt werden konnte, hat jede Methode spezifische Eigenheiten und gewichtet unterschiedliche Fehlertypen verschieden, wobei besonders die Spearman-Korrelation sowie Sortieralgorithmen aus der Informatik oft geeignet scheinen den Fehlergrad differenzierter zu bestimmen als klassische Methoden der statistischen Analyse. Möglicherweise erschließen sich auch, je nach Zweck der Auswertung, durch eine gewichtete Kombination zweier Algorithmen weitere geeignete Auswertungsmethoden.

