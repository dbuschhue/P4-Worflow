# Glossar

Aufgabenschwierigkeit

:   Die Aufgabenschwierigkeit ist ein latentes also nicht direkt sichtbares Maß für die Schwierigkeit einer Aufgabe. Sie wird bei Modellen aus der Item-Response-Theorie über den Aufgabenschwierigkeitsparameter $\delta$ (teilweise in der Literatur sowie Softwareanwendungen auch $\xi$ oder $\beta$) geschätzt, welcher Werte zwischen $-\infty$ und $\infty$ annehmen kann. Achtung! Man unterscheidet diesen Parameter von der Aufgabenschwierigkeit $M$ aus der klassischen Testtheorie ("KTT"), die als Verhältnis von erfolgreichen Lösungen $N_{gelöst}$ zu erfolgten Bearbeitungen $N_{bearbeitet}$ formuliert wird und in Prozent ausgedrückt werden kann: $M=\frac{N_{gelöst}}{N_{bearbeitet}}*100$. In der Folge gilt für die IRT: Je größer die Zahl, desto schwerer die Aufgabe. In der KTT ist eine Aufgabe umso schwerer, je kleiner der Zahlwert ist und dieser kann außerdem nur Werte zwischen $0$ und $1$, bzw. $0\%$ und $100\%$ annehmen.

ICC

:   Die _Item CharacteristicCurve_ kann zur Überprüfung der Modellpassung verwendet werden. Sie zeigt die modellierten Lösungswahrscheinlichkeiten der jeweiligen Aufgaben in Abhängigkeit der modellierten Personenfähigkeiten. Im R-Paket "TAM" werden darüber hinaus die in (willkürlich bestimmbaren) Personenfähigkeitsgruppen gemittelten, empirischen Lösungsanteile über der Modellkurve abgetragen. So kann manuell geprüft werden, wie gut die Vorhersage des Modells über alle Aufgaben und Personen und die empirisch gefundenen Lösungsanteile für einzelne Aufgaben zusammenpassen. Im Idealfall liegen beide Kurven eng übereinander, in realen Studiendatensätzen sind entdeckte Diskrepanzen ein gut erkennbarer Indikator zur Überprüfung der Aufgaben. Die Abkürzung _ICC_ ist auch in so genannten Mehrebenenmodellen zu finden, steht dort für _Intraclass Correlation Coefficient_ und sollte nicht mit den _Item Characteristic Curves_ aus der Item Response Theorie verwechselt werden.

Lösungswahrscheinlichkeit

:   Die Lösungswahrscheinlichkeit $P$ also die Wahrscheinlichkeit, dass eine Person $n$ mit einer Fähigkeit $\theta_n$ eine Aufgabe $i$ der Schwierigkeit $\delta_i$ lösen. Da die Wahrscheinlichkeit von diesen zwei Parametern abhängt, schreibt man häufig $P(1|\theta_n, \delta_i)$ für die Wahrscheinlichkeit einer richtigen Lösung (1). $P(0|\theta_n, \delta_i)$ wäre analog die Wahrscheinlichkeit, die Aufgabe nicht zu lösen.

Personenfähigkeit

:   Die Personenfähigkeit ist ein latentes also nicht direkt sichtbares Maß für die Fähigkeit einer Person. Diese Fähigkeit kann natürlich von Bereich zu Bereich (teilweise auch Dimension genannt) unterschiedlich sein. Die Fähigkeit wird über den Fähigkeitsparameter $\theta$ geschätzt, welcher Werte zwischen $-\infty$ und $\infty$ annehmen kann.

Wright-Map

:   Die Wright-Map ist eine grafische Darstellung zur Gegenüberstellung von Aufgabenschrierigkeiten und Personenfähigkeiten. Anhand dieser kann überprüft werden, ob die Schwierigkeiten der Aufgaben den Bereich der Fähigkeiten der Personen gut abdecken, die Aufgaben also weder zu schwer noch zu leicht für die getesteten Personen sind.



