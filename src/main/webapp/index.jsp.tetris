```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Arcade Tetris</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;

            background:
                radial-gradient(
                    circle at top,
                    #29294d 0%,
                    #111122 45%,
                    #050509 100%
                );

            color: white;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .arcade {

            width: 850px;
            max-width: 95vw;

            padding: 25px;

            background: rgba(20, 20, 35, 0.96);

            border: 2px solid #444466;

            border-radius: 20px;

            box-shadow:
                0 0 40px rgba(0, 255, 180, 0.10),
                0 20px 60px rgba(0, 0, 0, 0.7);
        }

        .title {
            text-align: center;
            margin-bottom: 20px;
        }

        .title h1 {

            margin: 0;

            font-size: 42px;

            letter-spacing: 8px;

            color: #5fffd2;

            text-shadow:
                0 0 15px rgba(95, 255, 210, 0.7);
        }

        .title p {

            margin: 8px 0 0;

            color: #aaaac5;
        }

        .game-area {

            display: flex;

            justify-content: center;

            align-items: flex-start;

            gap: 25px;
        }

        .board-container {
            position: relative;
        }

        #game {

            display: block;

            background: #080810;

            border: 3px solid #30304a;

            border-radius: 8px;

            box-shadow:
                inset 0 0 30px rgba(0, 0, 0, 0.8),
                0 0 20px rgba(95, 255, 210, 0.08);
        }

        .side-panel {

            width: 180px;

            display: flex;

            flex-direction: column;

            gap: 15px;
        }

        .panel {

            padding: 15px;

            background: #0b0b16;

            border: 1px solid #33334d;

            border-radius: 12px;
        }

        .panel-title {

            color: #9999b0;

            font-size: 12px;

            letter-spacing: 2px;

            margin-bottom: 8px;
        }

        .score {

            font-size: 28px;

            font-weight: bold;

            color: #5fffd2;

            text-shadow:
                0 0 10px rgba(95, 255, 210, 0.4);
        }

        .level {

            font-size: 22px;

            color: #ffffff;
        }

        .lines {

            font-size: 22px;

            color: #ffffff;
        }

        #next {

            display: block;

            margin: auto;

            background: #080810;

            border-radius: 6px;
        }

        button {

            border: none;

            border-radius: 10px;

            padding: 12px 20px;

            background: #5fffd2;

            color: #07100d;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.2s;
        }

        button:hover {

            transform: translateY(-2px);

            box-shadow:
                0 5px 20px rgba(95, 255, 210, 0.3);
        }

        .game-over {

            position: absolute;

            inset: 0;

            display: none;

            flex-direction: column;

            justify-content: center;

            align-items: center;

            background:
                rgba(5, 5, 12, 0.88);

            border-radius: 6px;

            text-align: center;
        }

        .game-over h2 {

            margin: 0 0 10px;

            font-size: 38px;

            color: #ff5577;

            text-shadow:
                0 0 15px rgba(255, 85, 119, 0.6);
        }

        .game-over p {

            color: #ccccdd;

            margin-bottom: 20px;
        }

        .controls {

            margin-top: 20px;

            text-align: center;

            color: #9999b0;

            font-size: 14px;
        }

        .keys {

            margin-top: 10px;

            color: #dddded;
        }

        kbd {

            display: inline-block;

            padding: 5px 9px;

            margin: 2px;

            background: #24243a;

            border: 1px solid #4a4a66;

            border-radius: 5px;

            box-shadow:
                0 2px 0 #11111d;
        }

        .mobile-controls {

            display: none;

            margin: 20px auto 0;

            width: 220px;

            grid-template-columns:
                repeat(3, 60px);

            gap: 8px;

            justify-content: center;
        }

        .mobile-controls button {

            padding: 12px;

            font-size: 20px;

            background: #25253d;

            color: #5fffd2;
        }

        .empty {

            visibility: hidden;
        }

        @media (max-width: 700px) {

            .arcade {
                padding: 15px;
            }

            .title h1 {
                font-size: 30px;
            }

            .game-area {
                flex-direction: column;
                align-items: center;
            }

            .side-panel {

                width: 100%;

                display: grid;

                grid-template-columns:
                    repeat(3, 1fr);
            }

            .side-panel .next-panel {
                grid-column: span 3;
            }

            .side-panel button {
                grid-column: span 3;
            }

            .controls {
                display: none;
            }

            .mobile-controls {
                display: grid;
            }
        }

    </style>

</head>


<body>


<div class="arcade">


    <div class="title">

        <h1>TETRIS</h1>

        <p>Classic Arcade Edition</p>

    </div>


    <div class="game-area">


        <!-- GAME BOARD -->

        <div class="board-container">

            <canvas
                id="game"
                width="300"
                height="600">
            </canvas>


            <div
                class="game-over"
                id="gameOver">

                <h2>GAME OVER</h2>

                <p>
                    Final Score:
                    <strong id="finalScore">0</strong>
                </p>

                <button onclick="restartGame()">
                    PLAY AGAIN
                </button>

            </div>

        </div>


        <!-- SIDE PANEL -->

        <div class="side-panel">


            <div class="panel">

                <div class="panel-title">
                    SCORE
                </div>

                <div
                    class="score"
                    id="score">
                    0
                </div>

            </div>


            <div class="panel">

                <div class="panel-title">
                    LEVEL
                </div>

                <div
                    class="level"
                    id="level">
                    1
                </div>

            </div>


            <div class="panel">

                <div class="panel-title">
                    LINES
                </div>

                <div
                    class="lines"
                    id="lines">
                    0
                </div>

            </div>


            <div class="panel next-panel">

                <div class="panel-title">
                    NEXT
                </div>

                <canvas
                    id="next"
                    width="120"
                    height="120">
                </canvas>

            </div>


            <button onclick="restartGame()">
                RESTART GAME
            </button>


        </div>

    </div>


    <div class="controls">

        <div>
            Keyboard Controls
        </div>

        <div class="keys">

            <kbd>←</kbd>
            Move Left

            <kbd>→</kbd>
            Move Right

            <kbd>↓</kbd>
            Soft Drop

            <kbd>↑</kbd>
            Rotate

            <kbd>SPACE</kbd>
            Hard Drop

        </div>

    </div>


    <!-- MOBILE CONTROLS -->

    <div class="mobile-controls">

        <button class="empty">
        </button>

        <button onclick="rotatePiece()">
            ↻
        </button>

        <button class="empty">
        </button>


        <button onclick="move(-1)">
            ←
        </button>

        <button onclick="softDrop()">
            ↓
        </button>

        <button onclick="move(1)">
            →
        </button>


        <button
            style="grid-column: span 3"
            onclick="hardDrop()">

            DROP

        </button>

    </div>


</div>


<script>


/*
 * TETRIS GAME
 */


const canvas =
    document.getElementById("game");

const ctx =
    canvas.getContext("2d");


const nextCanvas =
    document.getElementById("next");

const nextCtx =
    nextCanvas.getContext("2d");


/*
 * Board dimensions
 */

const COLS = 10;

const ROWS = 20;

const BLOCK = 30;


/*
 * Tetris pieces
 */

const PIECES = [

    {
        name: "I",

        shape: [
            [1,1,1,1]
        ],

        color: "#00e5ff"
    },

    {
        name: "O",

        shape: [
            [1,1],
            [1,1]
        ],

        color: "#ffe600"
    },

    {
        name: "T",

        shape: [
            [0,1,0],
            [1,1,1]
        ],

        color: "#b967ff"
    },

    {
        name: "S",

        shape: [
            [0,1,1],
            [1,1,0]
        ],

        color: "#55ff77"
    },

    {
        name: "Z",

        shape: [
            [1,1,0],
            [0,1,1]
        ],

        color: "#ff5577"
    },

    {
        name: "J",

        shape: [
            [1,0,0],
            [1,1,1]
        ],

        color: "#5577ff"
    },

    {
        name: "L",

        shape: [
            [0,0,1],
            [1,1,1]
        ],

        color: "#ff9955"
    }

];


/*
 * Game variables
 */

let board;

let currentPiece;

let nextPiece;

let score = 0;

let lines = 0;

let level = 1;

let dropCounter = 0;

let dropInterval = 800;

let lastTime = 0;

let gameRunning = true;


/*
 * Create empty board
 */

function createBoard() {

    return Array.from(
        { length: ROWS },
        () => Array(COLS).fill(null)
    );

}


/*
 * Random piece
 */

function randomPiece() {

    const piece =
        PIECES[
            Math.floor(
                Math.random() *
                PIECES.length
            )
        ];

    return {

        shape:
            piece.shape.map(
                row => [...row]
            ),

        color: piece.color,

        name: piece.name,

        x: 0,

        y: 0
    };

}


/*
 * Start game
 */

function startGame() {

    board = createBoard();

    score = 0;

    lines = 0;

    level = 1;

    dropInterval = 800;

    gameRunning = true;

    nextPiece = randomPiece();

    spawnPiece();

    updateDisplay();

    document
        .getElementById("gameOver")
        .style.display = "none";

    requestAnimationFrame(update);

}


/*
 * Spawn new piece
 */

function spawnPiece() {

    currentPiece = nextPiece;

    nextPiece = randomPiece();

    currentPiece.x =
        Math.floor(
            COLS / 2 -
            currentPiece.shape[0].length / 2
        );

    currentPiece.y = 0;


    /*
     * Check game over
     */

    if (collision()) {

        endGame();

    }


    drawNext();

}


/*
 * Collision detection
 */

function collision() {

    const shape =
        currentPiece.shape;

    for (
        let y = 0;
        y < shape.length;
        y++
    ) {

        for (
            let x = 0;
            x < shape[y].length;
            x++
        ) {

            if (!shape[y][x]) {
                continue;
            }

            const boardX =
                currentPiece.x + x;

            const boardY =
                currentPiece.y + y;


            if (
                boardX < 0 ||
                boardX >= COLS ||
                boardY >= ROWS
            ) {

                return true;

            }


            if (
                boardY >= 0 &&
                board[boardY][boardX]
            ) {

                return true;

            }

        }

    }

    return false;

}


/*
 * Merge piece into board
 */

function merge() {

    currentPiece.shape.forEach(
        (row, y) => {

            row.forEach(
                (value, x) => {

                    if (value) {

                        board[
                            currentPiece.y + y
                        ][
                            currentPiece.x + x
                        ] =
                            currentPiece.color;

                    }

                }
            );

        }
    );

}


/*
 * Move piece
 */

function move(direction) {

    if (!gameRunning) {
        return;
    }

    currentPiece.x += direction;

    if (collision()) {

        currentPiece.x -= direction;

    }

}


/*
 * Soft drop
 */

function softDrop() {

    if (!gameRunning) {
        return;
    }

    currentPiece.y++;

    if (collision()) {

        currentPiece.y--;

        lockPiece();

    }

    dropCounter = 0;

}


/*
 * Hard drop
 */

function hardDrop() {

    if (!gameRunning) {
        return;
    }

    while (!collision()) {

        currentPiece.y++;

    }

    currentPiece.y--;

    lockPiece();

    dropCounter = 0;

}


/*
 * Rotate piece
 */

function rotatePiece() {

    if (!gameRunning) {
        return;
    }


    const oldShape =
        currentPiece.shape;


    const rotated =
        oldShape[0].map(
            (_, index) =>
                oldShape.map(
                    row =>
                        row[index]
                ).reverse()
        );


    currentPiece.shape = rotated;


    /*
     * Wall kick
     */

    if (collision()) {

        currentPiece.x++;

        if (collision()) {

            currentPiece.x -= 2;

            if (collision()) {

                currentPiece.x++;

                currentPiece.shape =
                    oldShape;

            }

        }

    }

}


/*
 * Lock piece
 */

function lockPiece() {

    merge();

    clearLines();

    spawnPiece();

    updateDisplay();

}


/*
 * Clear completed lines
 */

function clearLines() {

    let cleared = 0;


    for (
        let y = ROWS - 1;
        y >= 0;
        y--
    ) {

        if (
            board[y].every(
                cell => cell !== null
            )
        ) {

            board.splice(y, 1);

            board.unshift(
                Array(COLS).fill(null)
            );

            cleared++;

            y++;

        }

    }


    if (cleared > 0) {

        /*
         * Tetris scoring
         */

        const points = [
            0,
            100,
            300,
            500,
            800
        ];

        score +=
            points[cleared] * level;

        lines += cleared;


        /*
         * Increase level every 10 lines
         */

        level =
            Math.floor(lines / 10) + 1;


        /*
         * Increase game speed
         */

        dropInterval =
            Math.max(
                100,
                800 -
                (level - 1) * 70
            );

    }

}


/*
 * Game loop
 */

function update(time = 0) {

    if (!gameRunning) {

        draw();

        return;

    }


    const deltaTime =
        time - lastTime;

    lastTime = time;

    dropCounter += deltaTime;


    if (dropCounter > dropInterval) {

        softDrop();

    }


    draw();

    requestAnimationFrame(update);

}


/*
 * Draw board
 */

function draw() {

    ctx.fillStyle = "#080810";

    ctx.fillRect(
        0,
        0,
        canvas.width,
        canvas.height
    );


    /*
     * Grid
     */

    ctx.strokeStyle =
        "rgba(255,255,255,0.035)";

    ctx.lineWidth = 1;


    for (
        let x = 0;
        x <= COLS;
        x++
    ) {

        ctx.beginPath();

        ctx.moveTo(
            x * BLOCK,
            0
        );

        ctx.lineTo(
            x * BLOCK,
            canvas.height
        );

        ctx.stroke();

    }


    for (
        let y = 0;
        y <= ROWS;
        y++
    ) {

        ctx.beginPath();

        ctx.moveTo(
            0,
            y * BLOCK
        );

        ctx.lineTo(
            canvas.width,
            y * BLOCK
        );

        ctx.stroke();

    }


    /*
     * Existing blocks
     */

    board.forEach(
        (row, y) => {

            row.forEach(
                (color, x) => {

                    if (color) {

                        drawBlock(
                            ctx,
                            x,
                            y,
                            color
                        );

                    }

                }
            );

        }
    );


    /*
     * Current piece
     */

    if (
        currentPiece &&
        gameRunning
    ) {

        currentPiece.shape.forEach(
            (row, y) => {

                row.forEach(
                    (value, x) => {

                        if (value) {

                            drawBlock(
                                ctx,
                                currentPiece.x + x,
                                currentPiece.y + y,
                                currentPiece.color
                            );

                        }

                    }
                );

            }
        );

    }

}


/*
 * Draw individual block
 */

function drawBlock(
    context,
    x,
    y,
    color
) {

    const px = x * BLOCK;

    const py = y * BLOCK;


    context.fillStyle = color;

    context.shadowColor = color;

    context.shadowBlur = 8;


    context.fillRect(
        px + 2,
        py + 2,
        BLOCK - 4,
        BLOCK - 4
    );


    /*
     * Highlight
     */

    context.shadowBlur = 0;

    context.fillStyle =
        "rgba(255,255,255,0.18)";

    context.fillRect(
        px + 4,
        py + 4,
        BLOCK - 8,
        4
    );


    context.strokeStyle =
        "rgba(255,255,255,0.25)";

    context.strokeRect(
        px + 2,
        py + 2,
        BLOCK - 4,
        BLOCK - 4
    );

}


/*
 * Draw next piece
 */

function drawNext() {

    nextCtx.fillStyle = "#080810";

    nextCtx.fillRect(
        0,
        0,
        nextCanvas.width,
        nextCanvas.height
    );


    const shape =
        nextPiece.shape;


    const blockSize = 25;


    const width =
        shape[0].length *
        blockSize;

    const height =
        shape.length *
        blockSize;


    const offsetX =
        (nextCanvas.width - width) / 2;

    const offsetY =
        (nextCanvas.height - height) / 2;


    shape.forEach(
        (row, y) => {

            row.forEach(
                (value, x) => {

                    if (value) {

                        drawNextBlock(
                            offsetX +
                            x * blockSize,

                            offsetY +
                            y * blockSize,

                            blockSize,

                            nextPiece.color
                        );

                    }

                }
            );

        }
    );

}


/*
 * Draw next-piece block
 */

function drawNextBlock(
    x,
    y,
    size,
    color
) {

    nextCtx.fillStyle = color;

    nextCtx.shadowColor = color;

    nextCtx.shadowBlur = 8;


    nextCtx.fillRect(
        x + 2,
        y + 2,
        size - 4,
        size - 4
    );


    nextCtx.shadowBlur = 0;

}


/*
 * Update scoreboard
 */

function updateDisplay() {

    document
        .getElementById("score")
        .textContent = score;

    document
        .getElementById("lines")
        .textContent = lines;

    document
        .getElementById("level")
        .textContent = level;

}


/*
 * Game over
 */

function endGame() {

    gameRunning = false;

    document
        .getElementById("finalScore")
        .textContent = score;

    document
        .getElementById("gameOver")
        .style.display = "flex";

}


/*
 * Restart
 */

function restartGame() {

    cancelAnimationFrame(update);

    startGame();

}


/*
 * Keyboard controls
 */

document.addEventListener(
    "keydown",
    function(event) {

        switch (event.key) {

            case "ArrowLeft":

                move(-1);

                event.preventDefault();

                break;


            case "ArrowRight":

                move(1);

                event.preventDefault();

                break;


            case "ArrowDown":

                softDrop();

                event.preventDefault();

                break;


            case "ArrowUp":

                rotatePiece();

                event.preventDefault();

                break;


            case " ":

                hardDrop();

                event.preventDefault();

                break;

        }

    }
);


/*
 * Start
 */

startGame();


</script>

</body>

</html>
```

