c CSCI3180 Principles of Programming Languages
c --- Declaration ---
c I declare that the assignment here submitted is original 
c except for source material explicitly acknowledged. 
c I also acknowledge that I am aware of University policy 
c and regulations on honesty in academic work, and of the 
c disciplinary guidelines and procedures applicable to
c breaches of such policy and regulations, as contained in the
c website http://www.cuhk.edu.hk/policy/academichonesty/
c Assignment 1
c Name: 
c Student ID: 
c Email Addr: 

      program helloworld
      implicit none

C variables
      INTEGER count
      INTEGER index
      INTEGER i, j, k
      REAL precnt

      INTEGER x1, y1, x2, y2
      character table(23, 79)
C program start

      open(UNIT=10, ERR=20, FILE='input.txt', STATUS='OLD')
      read(10, 11) count
 11   FORMAT(I2)

c      read(10, 12) x1, y1
 12   FORMAT(I2, X, I2)

c initial table cells
      GOTO 100
 199  k = 0

c read points
      GOTO 300
c draw last dot
 399  table(j, i) = '*'

      open(UNIT=20, ERR=21, FILE='output.txt', STATUS='NEW')
c print table cells
      GOTO 200
 299  k = 0
      close(10)
      close(20)

      stop

c error handling
 20   write (*, '(a)') 'Failed open'
      stop
 21   write (*, '(a)') 'Cannot open file to write, file exist?'
      stop

c initial table cells
 100  i = 1
      j = 1
 101  IF (j .GT. 23) GOTO 159
      table(j, i) = ' '
      i = i + 1
      IF (i .GT. 79) GOTO 102
      GOTO 103
 102  j = j + 1
      i = 1
 103  GOTO 101
c draw x axis
 159  i = 1
 160  IF (i .GT. 79) GOTO 162
      table(1, i) = '-'
      i = i + 1
      GOTO 160
c draw y axis
 162  i = 1
 163  IF (i .GT. 23) GOTO 164
      table(i, 1) = '|'
      i = i + 1
      GOTO 163
 164  table(1,1) = '+'
      GOTO 199

c print out the table
 200  i = 1
      j = 23
 201  IF (j .EQ. 0) GOTO 299
      IF (i .LT. 79) WRITE (*, '(a$)') table(j, i)
      IF (i .EQ. 79) WRITE (*, '(a)') table(j, i)
      IF (i .LT. 79) WRITE (20, '(a$)') table(j, i)
      IF (i .EQ. 79) WRITE (20, '(a)') table(j, i)
      i = i + 1
      IF (i .GT. 79) GOTO 202
      GOTO 203
 202  i = 1
      j = j - 1
 203  GOTO 201

c read points
 300  index = 1
      read (10, 12) x1, y1
c grid starts at 0, so needa add
      x1 = x1 + 1
      y1 = y1 + 1
      GOTO 303
c swap
 302  x1 = x2
      y1 = y2

 303  read (10, 12) x2, y2
c grid starts at 0, so needa add
      x2 = x2 + 1
      y2 = y2 + 1
      index = index + 1
c x1 and x2 at this point should be ok
c draw line
      GOTO 400
 499  IF (index .EQ. count) GOTO 399
      GOTO 302

c draw line
 400  IF (x1 .GT. x2) i = x1 - x2
      IF ((x2 .GT. x1) .OR. (x2 .EQ. x1)) i = x2 - x1
      IF (y1 .GT. y2) j = y1 - y2
      IF ((y2 .GT. y1) .OR. (y2 .EQ. y1)) j = y2 - y1
      IF (i .GT. j) GOTO 500
      GOTO 600
 599  k = 0
 699  k = 0
      GOTO 499

c loop x axis
 500  i = x1
 501  IF (i .EQ. x2) GOTO 599
      precnt = (REAL(i) - REAL(x1)) / (REAL(x2) - REAL(x1))
      j = precnt * (y2 - y1) + y1
      table(j, i) = '*'
      IF (x1 .LT. x2) i = i + 1
      IF (x1 .GT. x2) i = i - 1
      GOTO 501

c loop y axis
 600  j = y1
 601  IF (j .EQ. y2) GOTO 699
      precnt = (REAL(j) - REAL(y1)) / (REAL(y2) - REAL(y1))
      i = precnt * (x2 - x1) + x1
      table(j, i) = '*'
      IF (y1 .LT. y2) j = j + 1
      IF (y1 .GT. y2) j = j - 1
      GOTO 601

      end