<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Arcade Snake</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background:
                radial-gradient(circle at top, #25254d 0%, #101020 45%, #050509 100%);
            color: white;
            font-family: Arial, Helvetica, sans-serif;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .arcade {
            width: 720px;
            max-width: 95vw;
            padding: 25px;

            background: rgba(20, 20, 35, 0.95);
            border: 2px solid #444466;
            border-radius: 20px;

            box-shadow:
                0 0 30px rgba(0, 255, 180, 0.12),
                0 20px 60px rgba(0, 0, 0, 0.6);
        }

        .title {
            text-align: center;
            margin-bottom: 20px;
        }

        .title h1 {
            margin: 0;
            font-size: 42px;
            letter-spacing: 6px;
            color: #5fffd2;
            text-shadow: 0 0 15px rgba(95, 255, 210, 0.7);
        }

        .title p {
            margin: 8px 0 0;
            color: #aaaac5;
        }

        .score-board {
            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-bottom: 15px;
            padding: 12px 18px;

            background: #0b0b16;
            border-radius: 12px;
            border: 1px solid #33334d;
        }

        .score {
            font-size: 20px;
            font-weight: bold;
        }

        .score span {
            color: #5fffd2;
        }

        .game-wrapper {
            position: relative;
            width: 100%;
        }

        canvas {
            display: block;
            width: 100%;
            height: auto;

            background: #080810;
            border: 3px solid #30304a;
            border-radius: 10px;

            box-shadow:
                inset 0 0 30px rgba(0, 0, 0, 0.8),
                0 0 15px rgba(95, 255, 210, 0.08);
        }

        .game-over {
            position: absolute;
            inset: 0;

            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            background: rgba(5, 5, 12, 0.82);
            border-radius: 8px;
        }

        .game-over h2 {
            margin: 0 0 10px;
            font-size: 42px;
            color: #ff5577;
            text-shadow: 0 0 15px rgba(255, 85, 119, 0.6);
        }

        .game-over p {
            color: #ccccdd;
        }

        button {
            border: none;
            border-radius: 10px;

            padding: 12px 25px;

            background: #5fffd2;
            color: #07100d;

            font-size: 16px;
            font-weight: bold;

            cursor: pointer;

            transition: 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(95, 255, 210, 0.3);
        }

        .controls {
            text-align: center;
            margin-top: 20px;
            color: #9999b0;
            font-size: 14px;
        }

        .keys {
            margin-top: 8px;
            color: #dddded;
        }

        kbd {
            padding: 5px 9px;
            margin: 2px;

            background: #24243a;
            border: 1px solid #4a4a66;
            border-radius: 5px;

            box-shadow: 0 2px 0 #11111d;
        }

        .mobile-controls {
            display: none;
            margin: 20px auto 0;
            width: 180px;

            grid-template-columns: repeat(3, 55px);
            gap: 7px;
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

        @media (max-width: 600px) {

            .arcade {
                padding: 15px;
            }

            .title h1 {
                font-size: 30px;
            }

            .mobile-controls {
                display: grid;
            }

            .controls {
                display: none;
            }
        }
    </style>
</head>

<body>

<div class="arcade">

    <div class="title">
        <h1>🐍 SNAKE</h1>
        <p>Classic Arcade Edition</p>
    </div>

    <div class="score-board">

        <div class="score">
            SCORE: <span id="score">0</span>
        </div>

        <button onclick="restartGame()">
            RESTART
        </button>

    </div>

    <div class="game-wrapper">

        <canvas id="game" width="600" height="600"></canvas>

        <div class="game-over" id="gameOver">

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

    <div class="controls">

        <div>
            Use your keyboard to control the snake
        </div>

        <div class="keys">
            <kbd>↑</kbd>
            <kbd>↓</kbd>
            <kbd>←</kbd>
            <kbd>→</kbd>
        </div>

    </div>

    <!-- Mobile controls -->

    <div class="mobile-controls">

        <button class="empty"> </button>

        <button onclick="changeDirection('up')">
            ↑
        </button>

        <button class="empty"> </button>

        <button onclick="changeDirection('left')">
            ←
        </button>

        <button onclick="changeDirection('down')">
            ↓
        </button>

        <button onclick="changeDirection('right')">
            →
        </button>

    </div>

</div>


<script>

    const canvas = document.getElementById("game");
    const ctx = canvas.getContext("2d");

    const gridSize = 30;
    const tileSize = canvas.width / gridSize;

    let snake;
    let food;

    let direction;
    let nextDirection;

    let score;

    let gameRunning;
    let gameLoop;


    /*
     * Start the game
     */

    function startGame() {

        snake = [
            { x: 15, y: 15 },
            { x: 14, y: 15 },
            { x: 13, y: 15 }
        ];

        direction = "right";
        nextDirection = "right";

        score = 0;

        gameRunning = true;

        document.getElementById("score").textContent = score;
        document.getElementById("gameOver").style.display = "none";

        generateFood();

        clearInterval(gameLoop);

        gameLoop = setInterval(update, 100);

        draw();
    }


    /*
     * Generate food
     */

    function generateFood() {

        let valid = false;

        while (!valid) {

            food = {
                x: Math.floor(Math.random() * gridSize),
                y: Math.floor(Math.random() * gridSize)
            };

            valid = !snake.some(
                part => part.x === food.x && part.y === food.y
            );
        }
    }


    /*
     * Update game
     */

    function update() {

        if (!gameRunning) {
            return;
        }

        direction = nextDirection;

        const head = {
            x: snake[0].x,
            y: snake[0].y
        };


        /*
         * Move snake
         */

        switch (direction) {

            case "up":
                head.y--;
                break;

            case "down":
                head.y++;
                break;

            case "left":
                head.x--;
                break;

            case "right":
                head.x++;
                break;
        }


        /*
         * Wall collision
         */

        if (
            head.x < 0 ||
            head.x >= gridSize ||
            head.y < 0 ||
            head.y >= gridSize
        ) {

            endGame();
            return;
        }


        /*
         * Snake collision
         */

        if (
            snake.some(
                part => part.x === head.x && part.y === head.y
            )
        ) {

            endGame();
            return;
        }


        snake.unshift(head);


        /*
         * Food collision
         */

        if (
            head.x === food.x &&
            head.y === food.y
        ) {

            score++;

            document.getElementById("score").textContent = score;

            generateFood();

        } else {

            snake.pop();
        }


        draw();
    }


    /*
     * Draw everything
     */

    function draw() {

        /*
         * Background
         */

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

        ctx.strokeStyle = "rgba(255,255,255,0.035)";
        ctx.lineWidth = 1;

        for (let i = 0; i <= gridSize; i++) {

            ctx.beginPath();

            ctx.moveTo(
                i * tileSize,
                0
            );

            ctx.lineTo(
                i * tileSize,
                canvas.height
            );

            ctx.stroke();


            ctx.beginPath();

            ctx.moveTo(
                0,
                i * tileSize
            );

            ctx.lineTo(
                canvas.width,
                i * tileSize
            );

            ctx.stroke();
        }


        /*
         * Food
         */

        ctx.fillStyle = "#ff5577";

        ctx.shadowColor = "#ff5577";
        ctx.shadowBlur = 15;

        ctx.beginPath();

        ctx.arc(
            food.x * tileSize + tileSize / 2,
            food.y * tileSize + tileSize / 2,
            tileSize * 0.30,
            0,
            Math.PI * 2
        );

        ctx.fill();

        ctx.shadowBlur = 0;


        /*
         * Snake
         */

        snake.forEach((part, index) => {

            if (index === 0) {

                ctx.fillStyle = "#5fffd2";

            } else {

                ctx.fillStyle = "#35c9a5";
            }

            ctx.shadowColor = "#5fffd2";
            ctx.shadowBlur = index === 0 ? 12 : 5;

            ctx.beginPath();

            ctx.roundRect(
                part.x * tileSize + 2,
                part.y * tileSize + 2,
                tileSize - 4,
                tileSize - 4,
                6
            );

            ctx.fill();

            ctx.shadowBlur = 0;
        });


        /*
         * Eyes
         */

        drawEyes();
    }


    /*
     * Draw snake eyes
     */

    function drawEyes() {

        const head = snake[0];

        ctx.fillStyle = "#06100d";

        let eye1;
        let eye2;


        if (direction === "right") {

            eye1 = {
                x: head.x * tileSize + 20,
                y: head.y * tileSize + 9
            };

            eye2 = {
                x: head.x * tileSize + 20,
                y: head.y * tileSize + 21
            };

        } else if (direction === "left") {

            eye1 = {
                x: head.x * tileSize + 10,
                y: head.y * tileSize + 9
            };

            eye2 = {
                x: head.x * tileSize + 10,
                y: head.y * tileSize + 21
            };

        } else if (direction === "up") {

            eye1 = {
                x: head.x * tileSize + 9,
                y: head.y * tileSize + 10
            };

            eye2 = {
                x: head.x * tileSize + 21,
                y: head.y * tileSize + 10
            };

        } else {

            eye1 = {
                x: head.x * tileSize + 9,
                y: head.y * tileSize + 20
            };

            eye2 = {
                x: head.x * tileSize + 21,
                y: head.y * tileSize + 20
            };
        }


        ctx.fillRect(
            eye1.x,
            eye1.y,
            4,
            4
        );

        ctx.fillRect(
            eye2.x,
            eye2.y,
            4,
            4
        );
    }


    /*
     * Keyboard controls
     */

    document.addEventListener(
        "keydown",
        function(event) {

            switch (event.key) {

                case "ArrowUp":
                    changeDirection("up");
                    event.preventDefault();
                    break;

                case "ArrowDown":
                    changeDirection("down");
                    event.preventDefault();
                    break;

                case "ArrowLeft":
                    changeDirection("left");
                    event.preventDefault();
                    break;

                case "ArrowRight":
                    changeDirection("right");
                    event.preventDefault();
                    break;
            }
        }
    );


    /*
     * Change direction
     */

    function changeDirection(newDirection) {

        if (!gameRunning) {
            return;
        }


        /*
         * Prevent snake from
         * reversing into itself
         */

        if (
            newDirection === "up" &&
            direction !== "down"
        ) {

            nextDirection = "up";

        } else if (
            newDirection === "down" &&
            direction !== "up"
        ) {

            nextDirection = "down";

        } else if (
            newDirection === "left" &&
            direction !== "right"
        ) {

            nextDirection = "left";

        } else if (
            newDirection === "right" &&
            direction !== "left"
        ) {

            nextDirection = "right";
        }
    }


    /*
     * Game over
     */

    function endGame() {

        gameRunning = false;

        clearInterval(gameLoop);

        document.getElementById("finalScore").textContent = score;

        document.getElementById("gameOver").style.display = "flex";
    }


    /*
     * Restart
     */

    function restartGame() {

        startGame();
    }


    /*
     * Start automatically
     */

    startGame();

</script>

</body>
</html>
