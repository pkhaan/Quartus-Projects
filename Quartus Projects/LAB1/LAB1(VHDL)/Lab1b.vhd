ENTITY Lab1b IS
PORT ( x1, x2, x3 : IN BIT ;
f : OUT BIT ) ;
END Lab1b ;
ARCHITECTURE Behavior OF Lab1b IS BEGIN
f <= (x1 or x3) and (not x1 or x2 or not x3);
END Behavior ;