# Site 1: 
LAB 9 - Die Leistungsfähigkeit von MIPS
Ziele
- Lernen, wie man die Leistung eines Prozessors bestimmt.
- Die Leistung des Prozessors durch Hinzufügen neuer Instruktionen zu verbessern.
Zu tun
- Bestimmen Sie die Geschwindigkeit des Prozessors aus Labor 8.
- Ermitteln Sie den Engpass bei der Berechnung.
- Verbessern Sie den Prozessor, indem Sie zusätzliche Standard-MIPS-Befehle implementieren.
- Ermitteln Sie die neue Leistung des Prozessors.
- Befolgen Sie die Anweisungen. Absätze, die wie der aktuelle Absatz grau hinterlegt sind, kennzeichnen
Beschreibungen, bei denen Sie etwas tun müssen.
- Um das Labor abzuschließen, müssen Sie Ihre Arbeit an einem der Takte demonstrieren.
- Sie werden einige Fragen im Laborbericht beantworten müssen.
- Alle optionalen Aufgaben sind sehr empfehlenswert. Sie können die Assistenten um ein Feedback zu den optionalen Aufgaben bitten.
Einführung
In den letzten Praktika haben wir einen kleinen funktionierenden Mikroprozessor auf der Basis des 32-bit MIPS gebaut. Die ALU wurde
Die ALU wurde in Labor 5 gebaut und ermöglichte es uns, eine Teilmenge der ursprünglichen R-Befehle zu implementieren. In Labor 7 haben wir
haben wir diese Befehle verwendet, um ein kleines Programm zu schreiben, das einen Bereich von aufeinanderfolgenden ganzen Zahlen addieren kann. Schließlich haben wir in Labor
8 ist es uns schließlich gelungen, Teile des MIPS zu unserem ersten Mikroprozessor zusammenzusetzen. In diesem Labor werden wir uns
die Leistung des Prozessors zu verbessern.
Leistung
Bevor wir beginnen, wollen wir den aktuellen Prozessor untersuchen und herausfinden, wie er verbessert werden kann. Schauen Sie in Labor 5 nach, wenn
Sie vergessen haben, wie man die Berichte in Vivado liest. Wir werden das Programm aus Labor 7 verwenden (das die Summe
(das alle Zahlen zwischen zwei ganzen Zahlen A und B zusammenzählt) als Benchmark in dieser Übung.
Das Problem der Addition aufeinanderfolgender Ganzzahlen ist bekannt, und wir können dies ausnutzen, um einen schnelleren
Algorithmus für diese Aufgabe zu entwickeln. Um die Summe aller Zahlen von 0 bis N zu finden, kann man die Gauß-Formel verwenden:
Um die Summe aller ganzen Zahlen von A bis B zu berechnen, können wir diese zuerst für B und dann für A-1 berechnen. Durch
Subtraktion dieser beiden erhalten wir die gewünschte Summe.
Da unser begrenzter Prozessor jedoch weder Multiplikations- noch Divisionsbefehle hat, können wir diesen Trick nicht
können wir diesen Trick jedoch nicht anwenden und müssen auf eine Brute-Force-Methode zurückgreifen, bei der alle Zahlen zwischen A und B einzeln summiert werden.
eins. Das Problem bei dieser Methode ist, dass die Ausführungszeit proportional zur Differenz zwischen den
Zahlen A und B.
Zusätzliche Anweisungen
Wir könnten die Leistung des Programms erheblich verbessern, indem wir die Gauß-Formel verwenden. Das erste
Problem ist die Division: Normalerweise ist die Division eine komplexe Operation. Für unsere Zwecke benötigen wir jedoch nur 

# 2: 
eine einfache Division durch zwei. Aus dem Unterricht sollten Sie wissen, dass die Division einer Binärzahl durch Potenzen von
zwei sehr einfach ist. Wir müssen nur die Bits der binären Darstellung der Zahl nach rechts verschieben.
Im Moment haben wir keinen Befehl in unserem Prozessor, der diese Operation ausführen kann, aber der ursprüngliche
MIPS-Befehlssatz hat einen Befehl namens srl (shift right logical) für diesen Zweck1
. Wir können diesen
Anweisung können wir die abschließende Division durch zwei durchführen. Wir brauchen jedoch noch eine Möglichkeit, zwei Zahlen zu multiplizieren.
Hierfür gibt es zwei Lösungen. Eine davon ist die Implementierung des Befehls multu2 (Multiplikation ohne Vorzeichen) aus dem
ursprünglichen MIPS-Befehlssatz. Die andere besteht darin, den Befehl sll (shift left logical) zu implementieren, der in der Lage wäre
mit zwei multiplizieren kann. Durch Verschieben und bedingtes Addieren des Multiplikanden ist es möglich, eine
bit-serielle Multiplikation mit den Befehlen sll, srl und add. Es steht Ihnen frei, diesen Ansatz auszuprobieren, aber wir
empfehlen jedoch die Implementierung des multu-Befehls. Im weiteren Verlauf dieses Praktikums gehen wir davon aus, dass Sie
den multu-Befehl zu implementieren.
Ergebnis der Multiplikation
Leider hören unsere Probleme hier nicht auf. Während es sehr einfach sein wird, die Kernfunktionalität des multu-Befehls zu implementieren
Kernfunktionalität des multu-Befehls zu implementieren, besteht das Problem darin, dass bei der Multiplikation zweier 32-Bit-Zahlen das Ergebnis
64 Bit benötigt. Die MIPS-Architektur erlaubt nur ein Rückschreiben von Registern, unterstützt also nicht das Schreiben eines
64-Bit-Wert zurück in die Registerdatei zu schreiben.
Eine Lösung ist die Verwendung von zwei zusätzlichen 32-Bit-Registern, die 'hi' und 'lo' genannt werden, um das 64-Bit-Ergebnis zu speichern.
Diese enthalten die höchstwertigen 32 Bits bzw. die niedrigstwertigen 32 Bits der Multiplikation.
Da diese Register nicht Teil der Standardregisterdatei sind, kann auf sie nicht direkt mit anderen
Anweisungen zugegriffen werden. MIPS bietet zwei zusätzliche Befehle zum Verschieben von Daten aus diesen Registern: mfhi (move from
hi) und mflo (move from lo)3
. Wenn wir uns für die Verwendung des mutlu-Befehls entscheiden, müssen wir diese
Befehle ebenfalls implementieren.
Bestimmen Sie die Leistung
Bevor wir mit der Arbeit an einer so großen Änderung an unserem Prozessor beginnen, sollten wir zunächst sicherstellen, dass sich der Aufwand tatsächlich lohnt.
der Aufwand lohnt. Für dieses Labor gehen wir davon aus, dass das Multiplikationsergebnis mit weniger als
32 Bits4
. Das bedeutet, dass das Multiplikationsergebnis so klein ist, dass es nur im Lo-Register gespeichert werden kann.
Sie haben hier zwei Möglichkeiten - wählen Sie diejenige, die Ihren Anforderungen entspricht.
Option 1 (anspruchsvoll): Verwenden Sie den MARS-Simulator, um eine schnellere Version des Codes zu schreiben, den Sie in Labor 7 geschrieben haben.
Stellen Sie sicher, dass der Code funktionsfähig ist, indem Sie ihn für kleinere Werte testen5
. Wenn Sie Probleme haben mit
dem MARS-Simulator oder der Baugruppe haben, lesen Sie bitte in Labor 7 nach.
Option 2 (einfach): Laden Sie die Datei Lab9_helpers.zip von der Kurs-Website herunter und entpacken Sie sie. Diese Datei enthält
eine schnellere Version des Assemblercodes, der bereits in "helper_mul.asm" für Sie implementiert ist. Sie können auch versuchen
im MARS-Simulator auszuführen, um sich von der Korrektheit des Codes zu überzeugen.
1 Es gibt auch eine ähnliche Anweisung namens sra (shift right arithmetic), der Unterschied ist, dass bei einer logischen Verschiebung
Nullen von der linken Seite eingefügt werden, während bei der arithmetischen Verschiebung das Vorzeichen (MSB) erhalten bleibt. Da die
Zahlen in unserem Beispiel alle positive ganze Zahlen sind, hätten sra und srl das gleiche Ergebnis geliefert, aber srl ist
einfacher zu implementieren.
2 In ähnlicher Weise gibt es einen mult-Befehl, bei dem die Operanden vorzeichenbehaftet sein können. Da alle Zahlen positiv sein werden,
mult und multu das gleiche Ergebnis liefern, aber multu ist einfacher zu implementieren. 3 Es gibt auch die Befehle mthi (move to hi) und mtlo (move to lo), um Daten in diesen Registern zu speichern, aber wir
brauchen diese Funktionalität nicht.
4 Um die vollen 64 Bits zu nutzen, bräuchten wir sowohl Hi als auch Lo-Register. Die Schiebeoperation wäre dann etwas
komplexer, da wir das Bit, das aus dem Hi-Register herausgeschoben wird, als MSB des Lo-Registers hinzufügen müssten.
Um das Labor überschaubarer zu machen, gehen wir davon aus, dass das Lo-Register das vollständige Ergebnis enthält.
Das begrenzt die maximale Anzahl, die wir verwenden können, auf etwas mehr als 32'000. 5 Obwohl es verlockend ist, sollten Sie für A und B keine größeren Werte als 100 verwenden, da die Simulation sonst sehr lange dauert.
lange dauern und Ihnen keine zusätzlichen Informationen liefern.

# 3: 
Bitte beachten Sie, dass der Simulator zwar alle gültigen Anweisungen akzeptiert, unser MIPS aber nur eine Handvoll Anweisungen unterstützt
Instruktionen unterstützt (die in Lab 6 und die neuen srl, mflo und multu). Stellen Sie sicher, dass Sie nur die erlaubten
Befehle verwenden.
Ändern Sie den Prozessor
Dies ist der etwas schwierigere Teil. Beachten Sie, dass alle drei Befehle eigentlich R-Befehle sind. Wenn Sie
erinnern, hatten wir in der letzten Übung das ALUControl-Signal in der ControlUnit 6 Bit breit gelassen
(obwohl wir damals nur 4 Bits benötigten).
Laden Sie die Datei Lab9_student.zip von der Kurs-Website herunter. Sie enthält ein Vivado-Projekt mit dem Prozessor
der in Lab 8 entwickelt wurde (MIPS.v) und eine Testbench (MIPS_test.v) zum Testen des Prozessors. Wenn Sie sich die Datei MIPS.v
Datei ansehen, werden Sie feststellen, dass wir die Ausgabe des Prozessors geändert haben, um die Fehlersuche zu erleichtern. Das Projekt
enthält auch die ALU.v aus Labor 8, die Sie ändern müssen.
Ihre Aufgabe ist es, die ALU-Komponente so zu ändern, dass:
1. Sie akzeptiert ein 6-Bit-ALU-Signal.
2. Sie akzeptiert ein 5-Bit ShAmt (Shift amount) vom MIPS.
3. Er nimmt den Eingang B und verschiebt den Wert um ShAmt Bits nach rechts, wenn aluop 6'b000010 (srl) ist.
4. Er multipliziert A und B und schreibt das Ergebnis in ein internes 32-Bit-Register Lo, wenn aluop gleich 6'b011001
(multu). Beachten Sie, dass Sie für das Register auch Takt- und Reset-Signale in die Schnittstelle einfügen müssen
hinzufügen.
5. Es nimmt den aktuellen Wert des Registers Lo und kopiert ihn an den Ausgang, wenn aluop 6'b010010
(mflo).
Stellen Sie sicher, dass andere Anweisungen nicht beeinträchtigt werden.
Da wir die Schnittstelle der ALU geändert haben (die Verbindung zu aluop besteht jetzt aus 6 statt vier Bits, und wir
wir zusätzliche Takt- und Reset-Verbindungen benötigen), müssen wir auch die MIPS.v leicht modifizieren, um sicherzustellen, dass
dass die geänderte ALU korrekt angeschlossen ist.
Stellen Sie sicher, dass die neue ALU auf der obersten Ebene korrekt integriert ist. Dies erfordert kleine Änderungen an der Modul
Instanziierung innerhalb der MIPS.v-Datei. Sie müssen das ShAmt-Signal (Shift Amount) aus der
Anweisung (Instr-Signal) extrahieren, um es an die ALU zu übergeben. Möglicherweise müssen Sie dafür zusätzliche Drähte deklarieren. Sie können
Bitpositionen für ShAmt finden Sie in den MIPS-Referenzdaten:
https://safari.ethz.ch/digitaltechnik/spring2022/lib/exe/fetch.php?media=mips_reference_data.pdf
Zeigen und beschreiben Sie Ihre Designänderungen einem TA.
Leistung
Wir haben einen neuen Prozessor, der hoffentlich die Berechnungszeit für große Zahlen erheblich reduziert.
Diese Verbesserung ist mit Kosten verbunden. Es gibt eine komplexere Operation in der ALU-Komponente
des Prozessors (Multiplikation), die theoretisch auch die Länge des kritischen Pfades erhöhen sollte.
Wenn Sie die beiden Implementierungen vergleichen, werden Sie feststellen, dass dies nicht wirklich offensichtlich ist. Zunächst einmal nutzt der
Synthesizer die eingebauten Multiplizierer im FPGA zur Implementierung des teuren Multiplikators verwenden.
Diese sind wesentlich schneller als der Aufbau eines Multiplikators mit einzelnen Gattern, so dass Sie wahrscheinlich keinen
den Nachteil im Timing nicht bemerken.
Um den Code einfach zu halten, verwenden wir einen sehr einfachen Ansatz für den Befehlsspeicher. Das Programm ist definiert
als eine konstante Nachschlagetabelle definiert. Da das Programm in den Prozessor eingebettet ist, ist der Synthesizer in der Lage
erkennen, welche Teile des Prozessors nicht verwendet werden, und kann diese Teile wegoptimieren. Wenn Sie einen
Multiplikator haben, aber keine Anweisung, die ihn verwendet, ist es nicht notwendig, einen Multiplikator zu synthetisieren. Daraus folgt,
hängen die angezeigten Bereichszahlen auch von dem geladenen Programm ab. Das macht Vergleiche knifflig 

# 4: 
Überprüfung
Wir folgen dem Beispiel aus Labor 7 und stellen sicher, dass das Endergebnis in das Register $t2 geschrieben wird. Wir warten dann
warten wir, bis sich der Prozessor in einer Schleife befindet (PC entspricht dem Ende der Schleife) und überprüfen den Inhalt des Registers, um zu sehen
ob der Wert tatsächlich korrekt ist. Dazu haben Sie wiederum zwei Möglichkeiten:
Option 1 (anspruchsvoll): Ihr Assemblerprogramm muss in die Textdatei mit dem Namen "insmem_h.txt" kopiert werden.
Dazu können Sie die Option "Memory Dump" im MARS-Simulator verwenden. Durch Auswahl des "Speicher
Segment" als ".text" und "Dump Format" als "Hexadezimaler Text" auswählen, können Sie die erforderliche
Datei erzeugen. Sie müssen lediglich einen Editor verwenden und darauf achten, dass die Datei genau 64 Zeilen hat; alle Zeilen nach Ihrem
eigentlichen Code werden mit Nullen aufgefüllt. Wenn etwas unklar ist, sehen Sie in Labor 7 nach.
Option 2 (einfach): Die Datei Lab9_helpers.zip enthält eine Datei "helper_insmem_h.txt", die das Binärprogramm
Programm enthält, das dem Assemblerprogramm "helper_mul.asm" entspricht. Benennen Sie "helper_insmem_h.txt" um in
"insmem_h.txt" um und legen Sie sie in denselben Ordner wie die Projektdateien.
Denken Sie daran, dass die Datei InstructionMemory.v "insmem_h.txt" liest, um ihren Inhalt zu initialisieren. Durch Ändern dieser
Datei ändern und Ihre Schaltung neu kompilieren, programmieren Sie Ihren Prozessor neu.
Verwenden Sie die Datei MIPS_test.v, um Ihren Prozessor wie zuvor beschrieben zu testen. Es handelt sich um eine vereinfachte Version der
die in Labor 6 verwendet wurde, in der wir die erwarteten Antworten nicht mehr einlesen müssen. Wir brauchen lediglich einen Takt
Generator, ein anfängliches Reset-Signal und genügend Zeit für den Prozessor, um die Berechnung zu beenden. Führen Sie den neuen
Prüfstand im Vivado-Simulator und beobachten Sie den Wert von 'result' und den PC im Wave-Fenster.
Zeigen Sie Ihren korrekt laufenden MIPS-Code einem TA.
Beachten Sie, dass dies ein eher ad-hoc Ansatz zur Verifikation ist und wenig überraschend nicht hilfreich ist, wenn das Ergebnis
falsch ist. In diesem Fall müssen Sie mehr Aufwand betreiben, um herauszufinden, warum die Schaltung nicht wie erwartet funktioniert.
wie erwartet. Dies könnte die Verfolgung zusätzlicher interner Signale im Waveform-Viewer, die Implementierung einer umfassenderen
umfassenderen Testbench oder jede andere Fehlersuchtechnik, die Ihnen bei der Identifizierung des Problems/der Probleme helfen könnte.
Einige Ideen
Jetzt, wo wir fast einen vollständigen Prozessor haben, können Sie versuchen, einige Ideen zu implementieren (optional).
- Verwenden Sie die Dateien aus den vorangegangenen Übungen, um die Ausgabe des Programms auf der 7-Segment-Anzeige darzustellen.
- Schreiben Sie ein Zählerprogramm in Assembler und zeigen Sie den Zähler auf der 7-Segment-Anzeige an.
- Schreiben Sie ein Assemblerprogramm, um die Eingänge A und B von den Schaltern zu übernehmen und die multiplizierte
Ausgabe auf der 7-Segment-Anzeige.
Abschließende Worte
In diesem Praktikum haben wir Anweisungen hinzugefügt, um die Leistung unseres Prozessors zu "verbessern". In der Tat haben wir nicht
die ursprüngliche MIPS-Architektur zu verbessern, haben wir lediglich einige der "fehlenden" Befehle zum Prozessor hinzugefügt.
Prozessor hinzugefügt. Die Hinzufügung hat ihren Preis: Es müssen mehr Befehle dekodiert werden und es werden mehr Hardware-Ressourcen
sind erforderlich. Prozessorentwickler stehen bei der Verbesserung ihrer Entwürfe oft vor diesem Zielkonflikt.
Da wir über das Hinzufügen von Befehlen sprechen, warum fügen wir sie nicht einfach so hinzu, wie es uns gefällt? Ein Beispiel,
Wir könnten eine Anweisung namens Gauss hinzufügen, die N nimmt, eins dazu addiert, um (N+1) zu erzeugen, diese Werte multipliziert
Werte multipliziert, das Ergebnis durch zwei dividiert und das Ergebnis in einem einzigen Zyklus zurückgibt. Das ist möglich, aber sobald wir anfangen
Nicht-Standard-Befehle zu MIPS hinzuzufügen, werden Werkzeuge (z. B. Compiler, Debugger wie MARS) nicht mehr
nicht mehr mit dieser geänderten Architektur arbeiten. Diese Tools müssten ebenfalls geändert werden, was Folgendes erfordert
zusätzliche Arbeit.
Es stellt sich auch die Frage, wie viel wir durch diesen Gauss-Befehl gewinnen würden. Das Hinzufügen einer Multiplikations
Befehls wurde die Rechenzeit für größere N enorm verkürzt (was uns Millionen von Zyklen erspart). Der Gauß
Anweisung könnte 4 Anweisungen auf eine einzige reduzieren. Das Problem ist, dass wir diese Anweisung nur zweimal benötigen
diese Anweisung nur zweimal benötigen würden, so dass wir insgesamt nur 6 Zyklen einsparen könnten, insgesamt kein sehr beeindruckender Gewinn für alle unsere
Bemühungen. Dies ist natürlich nicht immer der Fall. Die Erweiterung von Befehlssätzen ist ein aktives Forschungsgebiet, und in
können in einigen Fällen erhebliche Vorteile bei geringem Overhead erzielt werden.

# 6: 
Dies ist die letzte Übung und somit auch das Ende dieser Laborreihe. Zunächst hoffen wir, dass Sie etwas gelernt haben
etwas daraus gelernt haben. In kurzer Zeit (mit etwas Hilfe) haben Sie Ihren eigenen 32-Bit-Prozessor implementiert,
Programme für ihn geschrieben und seine Leistung verbessert.
Wir hoffen auch, dass Ihnen die Übungen Spaß gemacht haben und dass Sie nun ein besseres Verständnis für digitale Schaltungen und digitale
Design im Allgemeinen. Am Ende des Kurses können Sie mit Sicherheit sagen, dass Sie professionelle Werkzeuge für den digitalen Entwurf verwendet haben und
praktische Erfahrungen beim Entwurf von Schaltungen gesammelt haben, die nicht so weit von dem entfernt sind, was in der Industrie benötigt wird
