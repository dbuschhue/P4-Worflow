--- 
title: "Statistische Analysen mit R in den MINT-Didaktiken  \nEine Tutorial-Sammlung"
author: "Tina Grottke, Philipp Möhrke, Marvin Rost, David Buschhüter (Hrsg.)"
date: "2021-02-11"
bibliography: ["book.bib"]
description: Alles was ich hätte wissen wollen
documentclass: book
github-repo: dbuschhue/P4-Worflow
link-citations: true
site: "bookdown::bookdown_site"

url: https://github.com/dbuschhue/P4-Worflow


---

<meta name="google-site-verification" content="6NKjFLtgIS7tFKGP6aT5tyFy5xU8PhERieckafCh2Xw" />


<style type="text/css">
iframe {
  border: none;
}
</style>

# DISCLAIMER

DIE HERAUSGEBER:INNEN ÜBERNEHMEN KEINE VERANTWORTUNG FÜR DIE RICHTIGKEIT DER INFORMATIONEN. DARÜBER HINAUS IST DER GRUNDGEDANKE DES BUCHS, DIE QUALITÄT DURCH REVISION STÄNDIG ZU ERHÖHEN. DIE HERAUSGEBER:INNEN ÜBERNEHMEN ZUDEM KEINE VERANTWORTUNG FÜR INHALTE AUF VERLINKTEN WEBSEITEN.

# Ziel dieses Buches

Statistische Analysen in den MINT-Didaktiken sollten noch transparenter kommuniziert werden. Durch eine größere Transparenz würde eine verbesserte Diskussionsgrundlage für Common-Practices in der Datenanalyse geschaffen. In der Folge können auch Best-Practice-Beispiele entstehen, die vor allem Anfänger*innen Sicherheit geben.

Damit ist das Ziel dieses Buches in einem Buttom-Up-Ansatz Beiträge zu sammeln, die erprobte Kenntnisse und Beispiele zu statistischen Datenanalysen als Orientierungshilfe für Early-Career-Researchers bereitstellen.

# Wie kann ich zu diesem Sammelband einen Beitrag leisten?

**Wer kann einen Beitrag einreichen?**

Theoretisch kann jeder einen Beitrag einreichen, der mit dem Thema seines\*ihres Beitrags hinreichend vertraut ist. In erster Linie ist dieses Buch aber an Autor\*innen und Leser*innen aus dem Bereich (Science/Math) Education und Psychologie gerichtet.

**Welche Arten von Beiträgen können eingereicht werden?**

Ein einreichbarer Beitrag...

*	... ist interessant für die oben genannte Community .
*	... hat eine „Tutorialfunktion“ (Ziel sollte es sein, dass die Person im Anschluss eine entsprechende Analyse umsetzen kann und Parameter sowie den Output interpretieren kann).
*	... betrifft die Nutzung von R-Paketen, die für die oben genannte Community von Interesse sind (insbesondere zur Psychometrie).

Es gibt dabei zwei Arten von Beiträgen: 

1. Essentiell für das Buch ist der Gedanke der Kollaboration. Sie können also insbesondere beitragen, indem Sie die Beiträge anderer Autor*innen kommentieren. (Öffnen Sie Sie dazu einfach eine GitHub-Issue: https://github.com/dbuschhue/P4-Worflow/issues)
2. Kapitelbeitrag
3. Beiträge zum Kapitel Fehlvorstellungen
    * Aufgrund ihrer Kürze setzen wir voraus, dass diese Beiträge entsprechend in etwaigen Listen zur Darstellung der Publikationsleistung als *Kurzbeitrag* kenntlich gemacht werden.
 

**Inwiefern wird der Beitrag begutachtet?**

*	Der Beitrag wird hinsichtlich seiner grundsätzlichen Eignung begutachtet.
*	Es erfolgt dabei kein ausgiebiges Peer-Review-Verfahren (die grundsätzliche Idee ist, dass sich dieses Buch weiterentwickelt online, indem andere Autor*innen Verbesserungsvorschläge machen und kommentieren).

**Inwiefern bin ich im Anschluss noch involviert?**

*	Es wird erwartet, dass Sie im Fall von wichtigen Verbesserungsvorschlägen, den Artikel anpassen (dies betrifft insbesondere notwendige Korrekturen).
*	Sollte es zu einem Korrekturvorschlag kommen, werden Sie von den Herausgeber*innen benachrichtigt.

Hinweis:  Ein Wesensmerkmal des Buchs ist die permanente Revisionsfähigkeit. Wir schreiben kein Lehrbuch für die Umsetzung als universitäre Lehrveranstaltung, sondern lernen gemeinsam in der Auseinandersetzung mit dem Thema und mit den Beitragenden. Das ist neu und ungewohnt. Wir glauben aber, dass das ein bedeutsamer Beitrag für eine zukunftsfähige Wissenschaftscommunity ist.

**Wie kann ich den Beitrag einreichen?**

* Die technische Umsetzung erfolgt über die Plattform GitHub. Stellen Sie deswegen bevorzugt einen Pull-Request an das Repository mit Ihrem Beitrag und einer entsprechenden Nachricht.
*	Wenn Ihnen das nicht möglich ist, treten Sie mit den Herausgeber*innen über die Issues-Funktion auf GitHub in Kontakt. Wichtiger als die Nutzung von GitHub ist die inhaltliche Ebene der Beiträge. Bitte halten Sie aber unbedingt die Formatierungsrichtlinien ein (s. u.), um den Revisionsprozess zu beschleunigen und den Fokus auf den Inhalten zu belassen.

**Welche Formatierungsrichtlinien gelten für den Text?**

*	Die Beiträge sind im RMarkdown Format als Rmd-Datei einzureichen und genauer als Buchkapitel zu einem bookdown-Buch. Sollten Sie noch nie mit RMarkdown gearbeitet haben, empfehlen wir eine einsteigerfreundliche, deutschsprachige Videoreihe, die mit dem folgenden Video beginnt: https://www.youtube.com/watch?v=F-6iU1EHoc0 . 
* Weitere Informationen finden Sie hier:
    +	Bookdown: https://bookdown.org/; https://bookdown.org/yihui/bookdown/
    + R Markdown: https://rmarkdown.rstudio.com/
*	Der Beitrag ist in genderneutraler Sprache geschrieben.
*	Achten Sie auf eine angemessene Länge und Lesbarkeit.
*	Orientieren Sie sich an bisherigen Einreichungen.
* Wir haben ein Vorlage-Kapitel erstellt: Das Sie [hier](https://cryptpad.fr/file/#/2/file/HS9dXhUkzlPQ0PsdzLWG0zzC/) herunterladen können




**Welche Regeln gelten für den Code?**

*	Keine übermäßig langen Zeilen.
*	Keine unnötigen Redundanzen zwischen Text und R-Kommentaren.
*	Achten Sie auch auf gute Lesbarkeit des Codes.
*	Orientieren Sie sich an bisherigen Einreichungen in diesem Buch.

**Wie lange dauert die Begutachtung eines Beitrags?**

*	Wir möchten ein schnelles Verfahren umsetzen und gehen von einer Richtzeit von 1-2 Wochen je nach Zustand des Beitrags aus.

**Kann man meinen Beitrag zitieren?**

*	Natürlich, einfach als Beitrag eines Sammelbands mit dem Erscheinungsdatum ihres Artikels.
