var firstPlayer : string := ""
put "First player : " ..
get firstPlayer

var secondPlayer : string := ""
put "Second player : " ..
get secondPlayer

setscreen ("graphics:600;500")

const radius : int := maxx div 6 - 20
const squareWidth : int := maxx div 3
const squareHeight : int := maxy div 3

var b1 : int := -1
var b2 : int := -1
var b3 : int := -1
var b4 : int := -1
var b5 : int := -1
var b6 : int := -1
var b7 : int := -1
var b8 : int := -1
var b9 : int := -1

var player : int := 0
var winner : int := -1
var clicks : int := 0

procedure drawBoard
    drawfillbox (0, 0, 600, 500, black)

    % draw the horizontal lines
    drawline (0, maxy div 3, maxx, maxy div 3, yellow)
    drawline (0, 2 * maxy div 3, maxx, 2 * maxy div 3, yellow)

    % draw the vertical lines
    drawline (maxx div 3, 0, maxx div 3, maxy, yellow)
    drawline (2 * maxx div 3, 0, 2 * maxx div 3, maxy, yellow)
end drawBoard

procedure winnerBoard
    drawfillbox (0, 0, 600, 500, white)
end winnerBoard

procedure drawX (centerX : int, centerY : int)
    drawline (centerX - maxx div 6, centerY + maxy div 6,
	centerX + maxx div 6, centerY - maxy div 6, yellow)
    drawline (centerX - maxx div 6, centerY - maxy div 6,
	centerX + maxx div 6, centerY + maxy div 6, yellow)
end drawX

procedure drawO (centerX : int, centerY : int)
    drawoval (centerX, centerY, radius, radius, yellow)
end drawO

procedure mouseClick (var mouseX : int, var mouseY : int)
    var button : int := -1
    var upDown : int := -1

    Mouse.ButtonWait ("down", mouseX, mouseY, button, upDown)
    Mouse.ButtonWait ("up", mouseX, mouseY, button, upDown)
end mouseClick

procedure centerPoint (var mouseX : int, var mouseY : int)
    mouseX := (mouseX div (maxx div 3) * (maxx div 3) +
	mouseX div (maxx div 3) * (maxx div 3) + (maxx div 3)) div 2

    mouseY := (mouseY div (maxy div 3) * (maxy div 3) +
	mouseY div (maxy div 3) * (maxy div 3) + (maxy div 3)) div 2
end centerPoint

procedure checkForWinner
    %rows
    if b1 not= -1 and b2 not= -1 and b3 not= -1 and (b1 + b2 + b3) mod 3 = 0 or
       b4 not= -1 and b5 not= -1 and b6 not= -1 and (b4 + b5 + b6) mod 3 = 0 or
       b7 not= -1 and b8 not= -1 and b9 not= -1 and (b7 + b8 + b9) mod 3 = 0 or
    %columns
       b1 not= -1 and b4 not= -1 and b7 not= -1 and (b1 + b4 + b7) mod 3 = 0 or
       b2 not= -1 and b5 not= -1 and b8 not= -1 and (b2 + b5 + b8) mod 3 = 0 or
       b3 not= -1 and b6 not= -1 and b9 not= -1 and (b3 + b6 + b9) mod 3 = 0 or
    %diagonals
       b1 not= -1 and b5 not= -1 and b9 not= -1 and (b1 + b5 + b9) mod 3 = 0 or
       b3 not= -1 and b5 not= -1 and b7 not= -1 and (b3 + b5 + b7) mod 3 = 0 then

	winner := player
    end if
end checkForWinner

procedure updateGame (x : int, y : int)
    if player = 0 then
	drawX (x, y)
    else
	drawO (x, y)
    end if

    checkForWinner
    clicks := clicks + 1
    if winner = -1 then % no winner yet, the game continues
	player := (player + 1) mod 2
    end if
end updateGame

procedure processClick (x : int, y : int)
    var box : int := x div squareWidth + 3 * (y div squareHeight) + 1

    case box of
	label 1 :
	    if b1 = -1 then
		b1 := player
		updateGame (x, y)
	    end if
	label 2 :
	    if b2 = -1 then
		b2 := player
		updateGame (x, y)
	    end if
	label 3 :
	    if b3 = -1 then
		b3 := player
		updateGame (x, y)
	    end if
	label 4 :
	    if b4 = -1 then
		b4 := player
		updateGame (x, y)
	    end if
	label 5 :
	    if b5 = -1 then
		b5 := player
		updateGame (x, y)
	    end if
	label 6 :
	    if b6 = -1 then
		b6 := player
		updateGame (x, y)
	    end if
	label 7 :
	    if b7 = -1 then
		b7 := player
		updateGame (x, y)
	    end if
	label 8 :
	    if b8 = -1 then
		b8 := player
		updateGame (x, y)
	    end if
	label 9 :
	    if b9 = -1 then
		b9 := player
		updateGame (x, y)
	    end if
    end case
end processClick

% M A I N  P R O G R A M

var x : int := -1
var y : int := -1

drawBoard
loop
    exit when winner not= -1 or clicks = 9
    mouseClick (x, y)
    centerPoint (x, y)
    processClick (x, y)
end loop

var message : string := ""
var font : int := 0
font := Font.New ("serif:40")

if winner not= -1 or clicks = 9 then
    winnerBoard
end if

if winner = 0 then
    message := firstPlayer + " is the winner"
    var stringWidth : int := Font.Width (message, font)
    Draw.Text (message, maxx div 2 - stringWidth div 2, maxy div 2, font, blue)
elsif winner = 1 then
    message := secondPlayer + " is the winner"
    var stringWidth : int := Font.Width (message, font)
    Draw.Text (message, maxx div 2 - stringWidth div 2, maxy div 2, font, blue)
else
    message := "Tie between " + firstPlayer + " and " + secondPlayer
    var stringWidth : int := Font.Width (message, font)
    Draw.Text (message, maxx div 2 - stringWidth div 2, maxy div 2, font, blue)
end if
