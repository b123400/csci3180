000010 IDENTIFICATION DIVISION.
000020 PROGRAM-ID. HELLO.
000021* CSCI3180 Principles of Programming Languages
000022* --- Declaration ---
000023* I declare that the assignment here submitted is original 
000024* except for source material explicitly acknowledged. 
000025* I also acknowledge that I am aware of University policy 
000026* and regulations on honesty in academic work, and of the 
000027* disciplinary guidelines and procedures applicable to
000028* breaches of such policy and regulations, as contained in the
000029* website http://www.cuhk.edu.hk/policy/academichonesty/
000030* Assignment 1
000031* Name: 
000032* Student ID: 
000033* Email Addr: 
000034*
000040 ENVIRONMENT DIVISION.
000041 INPUT-OUTPUT SECTION.
000042 FILE-CONTROL.
000043     SELECT IN-FILE
000044         ASSIGN TO DISK
000045         ORGANIZATION IS LINE SEQUENTIAL.
000043     SELECT OUT-FILE
000044          ASSIGN TO DISK
000045          ORGANIZATION IS LINE SEQUENTIAL.
000050*
000060 DATA DIVISION.
000061 FILE SECTION.
000062 FD IN-FILE
000063       LABEL RECORDS ARE STANDARD
000064       VALUE OF FILE-ID IS "input.txt".
000065     01 THE-FILE.
000065        03 NUM-1   PIC 9.
000066        03 NUM-2   PIC 9.
000067        03 NOTHING PIC X.
000068        03 NUM-3   PIC 9.
000069        03 NUM-4   PIC 9.
000070*
000070 FD OUT-FILE
000070       LABEL RECORDS ARE STANDARD
000070       VALUE OF FILE-ID IS "output.txt".
000070     01 OUT-TABLE.
000070        03 OUT-CELL  PIC X OCCURS 79.
000070*
000070 WORKING-STORAGE SECTION.
000071 01 GRAPH-TABLE.
000072    03 THE-ROW  OCCURS 23.
000073      05 THE-CELL  PIC X OCCURS 79.
000074 01 POINT-COUNT PIC 99    VALUE 0.
000075 01 X1          PIC 9(2)  VALUE 0.
000076 01 Y1          PIC 9(2)  VALUE 0.
000077 01 X2          PIC 9(2)  VALUE 0.
000078 01 Y2          PIC 9(2)  VALUE 0.
000080* 2 TEMP VARIABLE
000081 01 VAR-I       PIC 9(2)  VALUE 0.
000082 01 VAR-J       PIC 9(2)  VALUE 0.
000082* VARIABLES FOR DRAWING LINES
000084 01 CELL-VALUE  PIC 99V99    VALUE ZERO.
000084* VARIABLES FOR LOOPING CELLS.
000085 01 CELL-I      PIC 9(2)  VALUE 0.
000086 01 CELL-J      PIC 99    VALUE 0.
000087* FOR READING NUMBER
000088 01 FST-NUM     PIC 99    VALUE 0.
000089 01 SND-NUM     PIC 99    VALUE 0.
000090*
000180 PROCEDURE DIVISION.
000181* MAIN PROGRAM
000190 MAIN-PARAGRAPH.
000200     OPEN INPUT IN-FILE.
000703     GO TO FILL-EMPTY-GRAPH.
000704 FILL-EMPTY-GRAPH-EXIT.
000705*    MOVE "A" TO THE-CELL(5, 5).
000706*    MOVE "z" TO THE-CELL(15, 20).
000710     GO TO LINK-NUMBERS.
000711 LINK-NUMBERS-EXIT.
099910* START WRITING FILE
099911     OPEN OUTPUT OUT-FILE.
000800     GO TO SHOW-GRAPH.
000801 SHOW-GRAPH-EXIT.
099900     CLOSE IN-FILE.
099915     CLOSE OUT-FILE.
099990     STOP RUN.
100000* DRAW THE BACKGROUND WITH AXIS
100010 FILL-EMPTY-GRAPH.
100011     MOVE 1 TO VAR-I.
100012     MOVE 1 TO VAR-J
100014     GO TO FILL-CELL-LOOP.
100015 FILL-CELL-LOOP-EXIT.
100016     GO TO FILL-X-AXIS.
100017 FILL-X-AXIS-EXIT.
100018     GO TO FILL-Y-AXIS.
100019 FILL-Y-AXIS-EXIT.
100020     MOVE "+" TO THE-CELL(1, 1).
100021     GO TO FILL-EMPTY-GRAPH-EXIT.
100099* DRAW ALL CELLS WITH SPACE
100100 FILL-CELL-LOOP.
100101     MOVE " " TO THE-CELL(VAR-J, VAR-I).
100103     ADD 1 TO VAR-I.
100104     IF VAR-I = 80
100105         MOVE 1 TO VAR-I.
100106     IF VAR-I = 1
100107         ADD 1 TO VAR-J.
100108     IF VAR-J < 24
100109         GO TO FILL-CELL-LOOP.
100110     GO TO FILL-CELL-LOOP-EXIT.
100200* DRAW THE X AXIS WITH -------
100201 FILL-X-AXIS.
100202     MOVE 1 TO VAR-I.
100203     GO TO FILL-X-AXIS-LOOP.
100204 FILL-X-AXIS-LOOP-EXIT.
100205     GO TO FILL-X-AXIS-EXIT.
100206 FILL-X-AXIS-LOOP.
100207     MOVE "-" TO THE-CELL(1, VAR-I).
100208     ADD 1 TO VAR-I.
100209     IF VAR-I < 80 GO TO FILL-X-AXIS-LOOP.
100210     GO TO FILL-X-AXIS-LOOP-EXIT.
100300* DRAW THE Y AXIS WITH |
100301 FILL-Y-AXIS.
100302     MOVE 1 TO VAR-I.
100303     GO TO FILL-Y-AXIS-LOOP.
100304 FILL-Y-AXIS-LOOP-EXIT.
100305     GO TO FILL-Y-AXIS-EXIT.
100306 FILL-Y-AXIS-LOOP.
100307     MOVE "|" TO THE-CELL(VAR-I, 1).
100308     ADD 1 TO VAR-I.
100309     IF VAR-I < 24 GO TO FILL-Y-AXIS-LOOP.
100310     GO TO FILL-Y-AXIS-LOOP-EXIT.
100900* PRINT THE GRAPH IN UPSIDEDOWN ORDER,
100900* BECAUSE 0,0 IS AT THE BOTTOM
100901 SHOW-GRAPH.
100902     MOVE 23 TO VAR-I.
100903     GO TO SHOW-GRAPH-LOOP.
100904 SHOW-GRAPH-LOOP-EXIT.
100905     GO TO SHOW-GRAPH-EXIT.
100906
100907 SHOW-GRAPH-LOOP.
100908     DISPLAY THE-ROW(VAR-I).
100908     MOVE THE-ROW(VAR-I) TO OUT-TABLE.
100909     WRITE OUT-TABLE.
100909     SUBTRACT 1 FROM VAR-I.
100910     IF VAR-I = 0
100911         GO TO SHOW-GRAPH-LOOP-EXIT.
100912     GO TO SHOW-GRAPH-LOOP.
101000* READ THE NUMBER ONE BY ONE
101100 LINK-NUMBERS.
101101     READ IN-FILE.
101101     MOVE 0 TO FST-NUM.
101101     IF NUM-1 NOT = " " MOVE NUM-1 TO FST-NUM.
101101     IF NUM-1 NOT = " " MULTIPLY 10 BY FST-NUM.
101101     ADD NUM-2 TO FST-NUM.
101103     MOVE FST-NUM TO POINT-COUNT.
101114     READ IN-FILE.
101115     MOVE 0 TO FST-NUM.
101115     IF NUM-1 NOT = " " MOVE NUM-1 TO FST-NUM.
101115     IF NUM-1 NOT = " " MULTIPLY 10 BY FST-NUM.
101115     ADD NUM-2 TO FST-NUM.
101115     MOVE 0 TO SND-NUM.
101115     IF NUM-3 NOT = " " MOVE NUM-3 TO SND-NUM.
101115     IF NUM-3 NOT = " " MULTIPLY 10 BY SND-NUM.
101115     ADD NUM-4 TO SND-NUM.
101117     MOVE FST-NUM TO X1.
101118     MOVE SND-NUM TO Y1.
101118* ADD 1 BECAUSE THE GRAPH START AT 0,0
101118* BUT THE ARRAY START AT 1
101118     ADD 1 TO X1.
101118     ADD 1 TO Y1.
101119* FROM NOW ON, VAR-I MEANS HOW MANY POINTS HAS BEEN READ
101120     MOVE 1 TO VAR-I.
101121* READ ALL THE POINTS
101122     GO TO READ-POINT-LOOP.
101123 READ-POINT-LOOP-EXIT.
101124* DRAW THE LAST POINT, BECAUSE WE DIDNT DRAW IT BELOW
101125     MOVE "*" TO THE-CELL(Y2, X2).
101126     GO TO LINK-NUMBERS-EXIT.
101130*
101131 READ-POINT-LOOP.
101132     GO TO READ-NEXT-POINT.
101133 READ-NEXT-POINT-EXIT.
101134     GO TO SHIFT-POINT.
101135 SHIFT-POINT-EXIT.
101136     ADD 1 TO VAR-I.
101137     IF VAR-I = POINT-COUNT
101121         GO TO READ-POINT-LOOP-EXIT.
101122     GO TO READ-POINT-LOOP.
101199*
101200 READ-NEXT-POINT.
101201     READ IN-FILE.
101202     GO TO PARSE-NUMBERS.
101203 PARSE-NUMBERS-EXIT.
101204     MOVE FST-NUM TO X2.
101205     MOVE SND-NUM TO Y2.
101205     ADD 1 TO X2.
101205     ADD 1 TO Y2.
101206     GO TO DRAW-LINE.
101207 DRAW-LINE-EXIT.
101208     GO TO READ-NEXT-POINT-EXIT.
101300*
101301 SHIFT-POINT.
101302     MOVE X2 TO X1.
101303     MOVE Y2 TO Y1.
101304     GO TO SHIFT-POINT-EXIT.
102000*
102001 DRAW-LINE.
102001     IF X1 > X2 COMPUTE CELL-I = X1 - X2.
102002     IF X1 < X2 OR X1 = X2 COMPUTE CELL-I = X2 - X1.
102003     IF Y1 > Y2 COMPUTE CELL-J = Y1 - Y2.
102004     IF Y1 < Y2 OR Y1 = Y2 COMPUTE CELL-J = Y2 - Y1.
102005     IF CELL-I > CELL-J
102007         GO TO DRAW-LINE-X.
102008     GO TO DRAW-LINE-Y.
102010 DRAW-LINE-X-Y-EXIT. 
102010     GO TO DRAW-LINE-EXIT.
102100*
102101 DRAW-LINE-X.
102112*     DISPLAY "X".
102113     MOVE X1 TO CELL-I.
102114     GO TO DRAW-LINE-X-LOOP.
102115 DRAW-LINE-X-LOOP-EXIT.
102116     GO TO DRAW-LINE-X-Y-EXIT.
102117* CALCULATE EACH Y AT EACH X
102118 DRAW-LINE-X-LOOP.
102118*     DISPLAY "A"
102118*     DISPLAY CELL-I.
102119     COMPUTE CELL-VALUE ROUNDED =
102120         (CELL-I - X1) / (X2 - X1) * (Y2 - Y1) + Y1.
102121     MOVE CELL-VALUE TO CELL-J.
102122     MOVE "*" TO THE-CELL(CELL-J, CELL-I).
102123     IF X2 > X1 ADD 1 TO CELL-I.
102124     IF X2 < X1 SUBTRACT 1 FROM CELL-I.
102126     IF CELL-I = X1 OR CELL-I = X2
102127         GO TO DRAW-LINE-X-LOOP-EXIT.
102128     GO TO DRAW-LINE-X-LOOP.
102200*
102201 DRAW-LINE-Y.
102202*     DISPLAY "Y".
102203     MOVE Y1 TO CELL-I.
102204     GO TO DRAW-LINE-Y-LOOP.
102205 DRAW-LINE-Y-LOOP-EXIT.
102206     GO TO DRAW-LINE-X-Y-EXIT.
102207* CALCULATE EACH X AT EACH Y
102208 DRAW-LINE-Y-LOOP.
102219     COMPUTE CELL-VALUE ROUNDED =
102220         (CELL-I - Y1) / (Y2 - Y1) * (X2 - X1) + X1.
102221     MOVE CELL-VALUE TO CELL-J.
102222     MOVE "*" TO THE-CELL(CELL-I, CELL-J).
102223     IF Y2 > Y1 ADD 1 TO CELL-I.
102224     IF Y2 < Y1 SUBTRACT 1 FROM CELL-I.
102225     IF CELL-I = Y1 OR CELL-I = Y2
102226         GO TO DRAW-LINE-Y-LOOP-EXIT.
102227     GO TO DRAW-LINE-Y-LOOP.
102230
103000 PARSE-NUMBERS.
103001     MOVE 0 TO FST-NUM.
103002     IF NUM-1 NOT = " " MOVE NUM-1 TO FST-NUM.
103003     IF NUM-1 NOT = " " MULTIPLY 10 BY FST-NUM.
103004     ADD NUM-2 TO FST-NUM.
103011     MOVE 0 TO SND-NUM.
103012     IF NUM-3 NOT = " " MOVE NUM-3 TO SND-NUM.
103013     IF NUM-3 NOT = " " MULTIPLY 10 BY SND-NUM.
103014     ADD NUM-4 TO SND-NUM.
103099     GO TO PARSE-NUMBERS-EXIT.