<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>Pixel Quest - Classic Arcade</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html,
body {
    width: 100%;
    height: 100%;
    overflow: hidden;
    background: #111827;
    font-family: Arial, Helvetica, sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
}

#gameWrapper {
    position: relative;
    width: min(100vw, 1100px);
    aspect-ratio: 16 / 9;
    max-height: 100vh;
    overflow: hidden;
    background: #65c7f7;
    box-shadow:
        0 0 0 4px #0f172a,
        0 0 40px rgba(0,0,0,.7);
}

canvas {
    width: 100%;
    height: 100%;
    display: block;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
}

/* ================= HUD ================= */

#hud {
    position: absolute;
    top: 12px;
    left: 15px;
    right: 15px;

    display: flex;
    justify-content: space-between;
    align-items: center;

    color: white;
    font-weight: bold;
    font-size: 17px;

    text-shadow:
        2px 2px 0 #000,
        -1px -1px 0 #000;

    pointer-events: none;
    z-index: 10;
}

.hudGroup {
    display: flex;
    gap: 18px;
}

.hudItem {
    min-width: 75px;
}

/* ================= MESSAGE ================= */

#message {
    position: absolute;
    left: 50%;
    top: 50%;

    transform: translate(-50%, -50%);

    width: min(90%, 550px);

    background: rgba(15,23,42,.94);
    color: white;

    border: 4px solid #f8fafc;
    border-radius: 12px;

    padding: 30px;

    text-align: center;

    box-shadow:
        0 12px 40px rgba(0,0,0,.5);

    z-index: 20;
}

#message h1 {
    font-size: clamp(30px, 6vw, 55px);
    margin-bottom: 10px;
}

#message p {
    color: #cbd5e1;
    line-height: 1.6;
    margin-bottom: 20px;
}

#startButton,
#restartButton {

    border: none;
    padding: 13px 30px;

    font-size: 18px;
    font-weight: bold;

    border-radius: 8px;

    cursor: pointer;

    background: #facc15;
    color: #111827;

    box-shadow:
        0 4px 0 #a16207;

    transition: .1s;
}

#startButton:hover,
#restartButton:hover {
    transform: translateY(-2px);
}

#startButton:active,
#restartButton:active {
    transform: translateY(3px);
    box-shadow: none;
}

/* ================= MOBILE CONTROLS ================= */

#mobileControls {
    position: absolute;
    bottom: 15px;
    left: 15px;
    right: 15px;

    display: none;

    justify-content: space-between;

    z-index: 15;

    pointer-events: none;
}

.controlSide {
    display: flex;
    gap: 10px;
}

.mobileButton {

    width: 62px;
    height: 62px;

    border-radius: 50%;

    border: 3px solid white;

    background: rgba(15,23,42,.65);

    color: white;

    font-size: 25px;
    font-weight: bold;

    display: flex;
    justify-content: center;
    align-items: center;

    user-select: none;

    pointer-events: auto;
}

.mobileButton:active {
    background: rgba(250,204,21,.85);
    color: #111827;
}

@media (max-width: 800px) {

    #mobileControls {
        display: flex;
    }

    #hud {
        font-size: 13px;
    }

    .hudGroup {
        gap: 8px;
    }

    .hudItem {
        min-width: auto;
    }

}

</style>
</head>

<body>

<div id="gameWrapper">

    <canvas id="game"></canvas>

    <div id="hud">

        <div class="hudGroup">

            <div class="hudItem">
                SCORE <span id="score">000000</span>
            </div>

            <div class="hudItem">
                COINS <span id="coins">00</span>
            </div>

        </div>

        <div class="hudGroup">

            <div class="hudItem">
                LIVES <span id="lives">3</span>
            </div>

            <div class="hudItem">
                <span id="level">WORLD 1-1</span>
            </div>

        </div>

    </div>


    <div id="message">

        <h1 id="messageTitle">
            PIXEL QUEST
        </h1>

        <p id="messageText">
            A classic arcade platform adventure
            <br><br>

            <b>← →</b> Move
            &nbsp;&nbsp;
            <b>SPACE</b> Jump
            <br>

            <b>P</b> Pause
            &nbsp;&nbsp;
            <b>R</b> Restart

        </p>

        <button id="startButton">
            START GAME
        </button>

    </div>


    <div id="mobileControls">

        <div class="controlSide">

            <button class="mobileButton" id="leftBtn">
                ◀
            </button>

            <button class="mobileButton" id="rightBtn">
                ▶
            </button>

        </div>

        <div class="controlSide">

            <button class="mobileButton" id="jumpBtn">
                ▲
            </button>

        </div>

    </div>

</div>


<script>

/* =========================================================
   PIXEL QUEST
   Classic arcade platformer
   ========================================================= */

const canvas = document.getElementById("game");
const ctx = canvas.getContext("2d");

const WIDTH = 960;
const HEIGHT = 540;

canvas.width = WIDTH;
canvas.height = HEIGHT;


/* =========================================================
   GAME STATE
   ========================================================= */

let gameRunning = false;
let paused = false;
let gameOver = false;
let levelComplete = false;

let score = 0;
let coins = 0;
let lives = 3;

let cameraX = 0;

let keys = {};

let lastTime = 0;


/* =========================================================
   PLAYER
   ========================================================= */

const player = {

    x: 100,
    y: 300,

    width: 32,
    height: 46,

    vx: 0,
    vy: 0,

    speed: 5.2,
    jumpPower: 14,

    gravity: 0.65,

    grounded: false,

    facing: 1,

    invulnerable: 0,

    spawnX: 100,
    spawnY: 300
};


/* =========================================================
   WORLD
   ========================================================= */

const worldWidth = 6500;


/* =========================================================
   PLATFORMS
   ========================================================= */

let platforms = [];

function createPlatforms() {

    platforms = [

        /* starting area */

        {x:0, y:480, w:900, h:60},
        {x:1000, y:480, w:700, h:60},
        {x:1800, y:480, w:850, h:60},

        {x:2750, y:480, w:800, h:60},
        {x:3650, y:480, w:900, h:60},
        {x:4700, y:480, w:800, h:60},
        {x:5650, y:480, w:850, h:60},

        /* floating platforms */

        {x:400, y:390, w:180, h:25},
        {x:690, y:330, w:160, h:25},

        {x:1100, y:380, w:170, h:25},
        {x:1350, y:315, w:180, h:25},

        {x:1900, y:380, w:180, h:25},
        {x:2200, y:320, w:180, h:25},
        {x:2450, y:390, w:150, h:25},

        {x:2900, y:360, w:190, h:25},
        {x:3200, y:300, w:180, h:25},

        {x:3800, y:390, w:170, h:25},
        {x:4100, y:320, w:190, h:25},

        {x:4800, y:380, w:170, h:25},
        {x:5050, y:310, w:190, h:25},

        {x:5750, y:380, w:180, h:25},
        {x:6050, y:320, w:190, h:25}
    ];
}


/* =========================================================
   BLOCKS
   ========================================================= */

let blocks = [];

function createBlocks() {

    blocks = [

        {x:250, y:330, w:40, h:40, type:"coin"},
        {x:290, y:330, w:40, h:40, type:"brick"},
        {x:330, y:330, w:40, h:40, type:"coin"},

        {x:760, y:270, w:40, h:40, type:"coin"},

        {x:1170, y:320, w:40, h:40, type:"brick"},
        {x:1210, y:320, w:40, h:40, type:"coin"},

        {x:1430, y:255, w:40, h:40, type:"coin"},

        {x:2000, y:330, w:40, h:40, type:"coin"},
        {x:2040, y:330, w:40, h:40, type:"brick"},

        {x:2300, y:270, w:40, h:40, type:"coin"},

        {x:2980, y:310, w:40, h:40, type:"coin"},
        {x:3020, y:310, w:40, h:40, type:"brick"},

        {x:3250, y:250, w:40, h:40, type:"coin"},

        {x:3900, y:340, w:40, h:40, type:"coin"},
        {x:4150, y:270, w:40, h:40, type:"brick"},

        {x:4900, y:330, w:40, h:40, type:"coin"},
        {x:5100, y:260, w:40, h:40, type:"coin"},

        {x:5850, y:330, w:40, h:40, type:"brick"},
        {x:6090, y:270, w:40, h:40, type:"coin"}
    ];
}


/* =========================================================
   COINS
   ========================================================= */

let coinObjects = [];

function createCoins() {

    coinObjects = [];

    const positions = [

        [160,430],
        [210,430],
        [260,430],

        [450,340],
        [500,340],

        [720,280],
        [770,280],

        [1100,330],
        [1150,330],

        [1370,265],
        [1420,265],

        [1920,330],
        [1970,330],

        [2230,270],
        [2280,270],

        [2500,340],

        [2940,310],
        [2990,310],

        [3250,250],
        [3300,250],

        [3750,430],
        [3800,430],
        [3850,430],

        [4130,270],
        [4180,270],

        [4850,330],
        [4900,330],

        [5070,260],
        [5120,260],

        [5780,330],
        [5830,330],

        [6050,270],
        [6100,270],

        [6250,420],
        [6300,420]
    ];

    positions.forEach(p => {

        coinObjects.push({

            x:p[0],
            y:p[1],

            radius:11,

            collected:false,

            spin:Math.random() * Math.PI * 2

        });

    });

}


/* =========================================================
   ENEMIES
   ========================================================= */

let enemies = [];

function createEnemies() {

    enemies = [

        {x:600, y:435, w:34, h:35, vx:-1.2, alive:true},
        {x:850, y:435, w:34, h:35, vx:1.2, alive:true},

        {x:1250, y:435, w:34, h:35, vx:-1.3, alive:true},

        {x:1550, y:435, w:34, h:35, vx:1.4, alive:true},

        {x:2050, y:435, w:34, h:35, vx:-1.2, alive:true},
        {x:2500, y:435, w:34, h:35, vx:1.3, alive:true},

        {x:3000, y:435, w:34, h:35, vx:-1.4, alive:true},

        {x:3450, y:435, w:34, h:35, vx:1.2, alive:true},

        {x:3950, y:435, w:34, h:35, vx:-1.3, alive:true},
        {x:4400, y:435, w:34, h:35, vx:1.3, alive:true},

        {x:4900, y:435, w:34, h:35, vx:-1.2, alive:true},

        {x:5400, y:435, w:34, h:35, vx:1.4, alive:true},

        {x:5900, y:435, w:34, h:35, vx:-1.2, alive:true}
    ];

}


/* =========================================================
   GOAL
   ========================================================= */

const goal = {

    x:6300,
    y:300,

    width:20,
    height:180

};


/* =========================================================
   INPUT
   ========================================================= */

window.addEventListener("keydown", e => {

    keys[e.code] = true;

    if (
        ["ArrowLeft","ArrowRight","ArrowUp","Space"].includes(e.code)
    ) {
        e.preventDefault();
    }

    if (e.code === "KeyP") {

        if (gameRunning && !gameOver && !levelComplete) {

            paused = !paused;

        }

    }

    if (e.code === "KeyR") {

        restartGame();

    }

});


window.addEventListener("keyup", e => {

    keys[e.code] = false;

});


/* =========================================================
   MOBILE CONTROLS
   ========================================================= */

function holdButton(button, key) {

    button.addEventListener("touchstart", e => {

        e.preventDefault();
        keys[key] = true;

    }, {passive:false});


    button.addEventListener("touchend", e => {

        e.preventDefault();
        keys[key] = false;

    }, {passive:false});


    button.addEventListener("mousedown", () => {

        keys[key] = true;

    });


    button.addEventListener("mouseup", () => {

        keys[key] = false;

    });


    button.addEventListener("mouseleave", () => {

        keys[key] = false;

    });

}


holdButton(
    document.getElementById("leftBtn"),
    "ArrowLeft"
);

holdButton(
    document.getElementById("rightBtn"),
    "ArrowRight"
);

const jumpButton = document.getElementById("jumpBtn");

jumpButton.addEventListener("touchstart", e => {

    e.preventDefault();

    keys["Space"] = true;

    setTimeout(() => {

        keys["Space"] = false;

    }, 120);

}, {passive:false});


/* =========================================================
   COLLISION
   ========================================================= */

function rectangleCollision(a,b) {

    return (

        a.x < b.x + b.w &&
        a.x + a.width > b.x &&
        a.y < b.y + b.h &&
        a.y + a.height > b.y

    );

}


/* =========================================================
   PLAYER UPDATE
   ========================================================= */

let jumpPressed = false;

function updatePlayer() {

    if (player.invulnerable > 0) {

        player.invulnerable--;

    }


    /* movement */

    if (
        keys["ArrowLeft"] ||
        keys["KeyA"]
    ) {

        player.vx -= 0.6;

        player.facing = -1;

    }


    if (
        keys["ArrowRight"] ||
        keys["KeyD"]
    ) {

        player.vx += 0.6;

        player.facing = 1;

    }


    if (
        !keys["ArrowLeft"] &&
        !keys["KeyA"] &&
        !keys["ArrowRight"] &&
        !keys["KeyD"]
    ) {

        player.vx *= 0.82;

    }


    if (player.vx > player.speed)
        player.vx = player.speed;

    if (player.vx < -player.speed)
        player.vx = -player.speed;


    /* jump */

    const wantsJump =
        keys["Space"] ||
        keys["ArrowUp"] ||
        keys["KeyW"];


    if (wantsJump && player.grounded && !jumpPressed) {

        player.vy = -player.jumpPower;

        player.grounded = false;

    }

    jumpPressed = wantsJump;


    /* gravity */

    player.vy += player.gravity;

    if (player.vy > 16)
        player.vy = 16;


    /* horizontal movement */

    player.x += player.vx;


    /* horizontal world limits */

    if (player.x < 0) {

        player.x = 0;
        player.vx = 0;

    }


    if (player.x + player.width > worldWidth) {

        player.x = worldWidth - player.width;

    }


    /* vertical movement */

    const oldY = player.y;

    player.y += player.vy;

    player.grounded = false;


    /* platform collision */

    for (const p of platforms) {

        if (

            player.x + player.width > p.x &&
            player.x < p.x + p.w &&
            oldY + player.height <= p.y &&
            player.y + player.height >= p.y &&
            player.vy >= 0

        ) {

            player.y = p.y - player.height;

            player.vy = 0;

            player.grounded = true;

        }

    }


    /* falling */

    if (player.y > HEIGHT + 150) {

        loseLife();

    }


    /* camera */

    const targetCamera =
        player.x - WIDTH * 0.38;

    cameraX +=
        (targetCamera - cameraX) * 0.08;


    if (cameraX < 0)
        cameraX = 0;

    if (cameraX > worldWidth - WIDTH)
        cameraX = worldWidth - WIDTH;


    /* goal */

    if (

        player.x + player.width > goal.x &&
        player.x < goal.x + goal.width &&
        player.y < goal.y + goal.height

    ) {

        finishLevel();

    }

}


/* =========================================================
   ENEMY UPDATE
   ========================================================= */

function updateEnemies() {

    for (const enemy of enemies) {

        if (!enemy.alive)
            continue;


        enemy.x += enemy.vx;


        /* reverse at world/platform boundaries */

        if (enemy.x < 0) {

            enemy.x = 0;
            enemy.vx *= -1;

        }


        if (enemy.x + enemy.w > worldWidth) {

            enemy.x = worldWidth - enemy.w;
            enemy.vx *= -1;

        }


        const enemyRect = {

            x:enemy.x,
            y:enemy.y,
            width:enemy.w,
            height:enemy.h

        };


        const playerRect = {

            x:player.x,
            y:player.y,
            width:player.width,
            height:player.height

        };


        if (rectangleCollision(playerRect, enemyRect)) {

            /* stomp */

            if (
                player.vy > 0 &&
                player.y + player.height <
                enemy.y + enemy.h * 0.65
            ) {

                enemy.alive = false;

                player.vy = -8;

                score += 100;

            }
            else {

                damagePlayer();

            }

        }

    }

}


/* =========================================================
   COINS UPDATE
   ========================================================= */

function updateCoins() {

    for (const coin of coinObjects) {

        if (coin.collected)
            continue;


        coin.spin += 0.12;


        const coinRect = {

            x:coin.x - coin.radius,
            y:coin.y - coin.radius,
            width:coin.radius * 2,
            height:coin.radius * 2

        };


        const playerRect = {

            x:player.x,
            y:player.y,
            width:player.width,
            height:player.height

        };


        if (rectangleCollision(playerRect, coinRect)) {

            coin.collected = true;

            coins++;

            score += 50;

        }

    }

}


/* =========================================================
   DAMAGE
   ========================================================= */

function damagePlayer() {

    if (player.invulnerable > 0)
        return;


    lives--;

    updateHUD();


    if (lives <= 0) {

        endGame();

        return;

    }


    player.x = player.spawnX;
    player.y = player.spawnY;

    player.vx = 0;
    player.vy = 0;

    player.invulnerable = 120;

}


/* =========================================================
   FALL / LIFE LOSS
   ========================================================= */

function loseLife() {

    if (player.invulnerable > 0)
        return;


    lives--;

    updateHUD();


    if (lives <= 0) {

        endGame();

        return;

    }


    player.x = player.spawnX;
    player.y = player.spawnY;

    player.vx = 0;
    player.vy = 0;

    player.invulnerable = 120;

}


/* =========================================================
   GAME OVER
   ========================================================= */

function endGame() {

    gameRunning = false;

    gameOver = true;

    document.getElementById("messageTitle")
        .textContent = "GAME OVER";


    document.getElementById("messageText")
        .innerHTML =
        "Final Score: <b>" +
        score +
        "</b><br><br>" +
        "Coins collected: <b>" +
        coins +
        "</b>";


    document.getElementById("startButton")
        .textContent = "PLAY AGAIN";


    document.getElementById("message")
        .style.display = "block";

}


/* =========================================================
   LEVEL COMPLETE
   ========================================================= */

function finishLevel() {

    if (levelComplete)
        return;


    levelComplete = true;

    gameRunning = false;


    score += 1000;


    updateHUD();


    document.getElementById("messageTitle")
        .textContent = "LEVEL COMPLETE!";


    document.getElementById("messageText")
        .innerHTML =
        "🏆 Excellent run!<br><br>" +
        "Score: <b>" +
        score +
        "</b><br>" +
        "Coins: <b>" +
        coins +
        "</b>";


    document.getElementById("startButton")
        .textContent = "PLAY AGAIN";


    document.getElementById("message")
        .style.display = "block";

}


/* =========================================================
   START / RESTART
   ========================================================= */

function resetWorld() {

    score = 0;
    coins = 0;
    lives = 3;

    cameraX = 0;

    gameOver = false;
    levelComplete = false;
    paused = false;


    player.x = player.spawnX;
    player.y = player.spawnY;

    player.vx = 0;
    player.vy = 0;

    player.invulnerable = 0;


    createPlatforms();
    createBlocks();
    createCoins();
    createEnemies();


    updateHUD();

}


function startGame() {

    resetWorld();

    gameRunning = true;

    document.getElementById("message")
        .style.display = "none";

}


function restartGame() {

    startGame();

}


document.getElementById("startButton")
    .addEventListener("click", startGame);


/* =========================================================
   HUD
   ========================================================= */

function updateHUD() {

    document.getElementById("score")
        .textContent =
        String(score).padStart(6,"0");


    document.getElementById("coins")
        .textContent =
        String(coins).padStart(2,"0");


    document.getElementById("lives")
        .textContent = lives;

}


/* =========================================================
   DRAW BACKGROUND
   ========================================================= */

function drawBackground() {

    /* sky */

    const gradient =
        ctx.createLinearGradient(
            0,
            0,
            0,
            HEIGHT
        );


    gradient.addColorStop(
        0,
        "#38bdf8"
    );


    gradient.addColorStop(
        1,
        "#bae6fd"
    );


    ctx.fillStyle = gradient;

    ctx.fillRect(
        0,
        0,
        WIDTH,
        HEIGHT
    );


    /* distant hills */

    ctx.fillStyle = "#86efac";


    for (
        let x = -300 - (cameraX * 0.15) % 600;
        x < WIDTH + 600;
        x += 600
    ) {

        ctx.beginPath();

        ctx.moveTo(x,470);

        ctx.quadraticCurveTo(
            x + 150,
            330,
            x + 300,
            470
        );

        ctx.quadraticCurveTo(
            x + 450,
            350,
            x + 600,
            470
        );

        ctx.closePath();

        ctx.fill();

    }


    /* clouds */

    ctx.fillStyle =
        "rgba(255,255,255,.8)";


    const clouds = [

        [150,100],
        [500,140],
        [800,80],
        [1200,120],
        [1600,90],
        [2100,150],
        [2700,100],
        [3400,130],
        [4200,90],
        [5000,130],
        [5900,80]

    ];


    for (const cloud of clouds) {

        const x =
            cloud[0] -
            cameraX * 0.25;

        const y = cloud[1];


        ctx.beginPath();

        ctx.arc(
            x,
            y,
            25,
            0,
            Math.PI * 2
        );

        ctx.arc(
            x + 30,
            y - 10,
            32,
            0,
            Math.PI * 2
        );

        ctx.arc(
            x + 65,
            y,
            25,
            0,
            Math.PI * 2
        );

        ctx.fill();

    }

}


/* =========================================================
   DRAW PLATFORMS
   ========================================================= */

function drawPlatforms() {

    for (const p of platforms) {

        const x = p.x - cameraX;

        if (
            x + p.w < 0 ||
            x > WIDTH
        )
            continue;


        /* top */

        ctx.fillStyle = "#22c55e";

        ctx.fillRect(
            x,
            p.y,
            p.w,
            8
        );


        /* soil */

        ctx.fillStyle = "#92400e";

        ctx.fillRect(
            x,
            p.y + 8,
            p.w,
            p.h - 8
        );


        /* texture */

        ctx.fillStyle = "#78350f";


        for (
            let bx = x + 10;
            bx < x + p.w;
            bx += 32
        ) {

            ctx.fillRect(
                bx,
                p.y + 18,
                15,
                5
            );

        }

    }

}


/* =========================================================
   DRAW BLOCKS
   ========================================================= */

function drawBlocks() {

    for (const b of blocks) {

        const x = b.x - cameraX;


        if (
            x + b.w < 0 ||
            x > WIDTH
        )
            continue;


        if (b.type === "coin") {

            ctx.fillStyle = "#fbbf24";

            ctx.fillRect(
                x,
                b.y,
                b.w,
                b.h
            );


            ctx.strokeStyle = "#92400e";

            ctx.lineWidth = 3;

            ctx.strokeRect(
                x + 2,
                b.y + 2,
                b.w - 4,
                b.h - 4
            );


            ctx.fillStyle = "#fff7ed";

            ctx.font = "bold 24px Arial";

            ctx.textAlign = "center";

            ctx.textBaseline = "middle";

            ctx.fillText(
                "?",
                x + 20,
                b.y + 21
            );

        }
        else {

            ctx.fillStyle = "#b45309";

            ctx.fillRect(
                x,
                b.y,
                b.w,
                b.h
            );


            ctx.strokeStyle = "#78350f";

            ctx.lineWidth = 2;

            ctx.strokeRect(
                x,
                b.y,
                b.w,
                b.h
            );


            ctx.beginPath();

            ctx.moveTo(
                x,
                b.y + 20
            );

            ctx.lineTo(
                x + 40,
                b.y + 20
            );

            ctx.moveTo(
                x + 20,
                b.y
            );

            ctx.lineTo(
                x + 20,
                b.y + 20
            );

            ctx.stroke();

        }

    }

}


/* =========================================================
   DRAW COINS
   ========================================================= */

function drawCoins() {

    for (const coin of coinObjects) {

        if (coin.collected)
            continue;


        const x =
            coin.x - cameraX;

        if (
            x < -30 ||
            x > WIDTH + 30
        )
            continue;


        const scale =
            Math.abs(
                Math.sin(coin.spin)
            );


        ctx.save();

        ctx.translate(
            x,
            coin.y
        );

        ctx.scale(
            0.45 + scale * 0.55,
            1
        );


        ctx.fillStyle = "#facc15";

        ctx.beginPath();

        ctx.arc(
            0,
            0,
            coin.radius,
            0,
            Math.PI * 2
        );

        ctx.fill();


        ctx.strokeStyle = "#a16207";

        ctx.lineWidth = 3;

        ctx.stroke();


        ctx.restore();

    }

}


/* =========================================================
   DRAW ENEMIES
   ========================================================= */

function drawEnemies() {

    for (const enemy of enemies) {

        if (!enemy.alive)
            continue;


        const x =
            enemy.x - cameraX;


        if (
            x < -50 ||
            x > WIDTH + 50
        )
            continue;


        /* body */

        ctx.fillStyle = "#7c3aed";

        ctx.beginPath();

        ctx.roundRect(
            x,
            enemy.y + 8,
            enemy.w,
            enemy.h - 8,
            8
        );

        ctx.fill();


        /* head */

        ctx.fillStyle = "#a78bfa";

        ctx.beginPath();

        ctx.arc(
            x + 17,
            enemy.y + 10,
            14,
            Math.PI,
            0
        );

        ctx.fill();


        /* eyes */

        ctx.fillStyle = "white";

        ctx.fillRect(
            x + 8,
            enemy.y + 10,
            7,
            8
        );

        ctx.fillRect(
            x + 20,
            enemy.y + 10,
            7,
            8
        );


        ctx.fillStyle = "#111827";

        ctx.fillRect(
            x + 11,
            enemy.y + 13,
            3,
            4
        );

        ctx.fillRect(
            x + 23,
            enemy.y + 13,
            3,
            4
        );


        /* feet */

        ctx.fillStyle = "#312e81";

        ctx.fillRect(
            x + 2,
            enemy.y + enemy.h - 4,
            12,
            5
        );

        ctx.fillRect(
            x + 20,
            enemy.y + enemy.h - 4,
            12,
            5
        );

    }

}


/* =========================================================
   DRAW PLAYER
   ========================================================= */

function drawPlayer() {

    if (
        player.invulnerable > 0 &&
        Math.floor(player.invulnerable / 6) % 2 === 0
    ) {

        return;

    }


    const x =
        player.x - cameraX;

    const y =
        player.y;


    ctx.save();

    ctx.translate(
        x,
        y
    );


    if (player.facing < 0) {

        ctx.scale(-1,1);

        ctx.translate(
            -player.width,
            0
        );

    }


    /* legs */

    ctx.fillStyle = "#1e3a8a";

    ctx.fillRect(
        6,
        30,
        8,
        16
    );

    ctx.fillRect(
        19,
        30,
        8,
        16
    );


    /* shoes */

    ctx.fillStyle = "#111827";

    ctx.fillRect(
        3,
        42,
        12,
        5
    );

    ctx.fillRect(
        19,
        42,
        12,
        5
    );


    /* body */

    ctx.fillStyle = "#2563eb";

    ctx.fillRect(
        5,
        18,
        23,
        18
    );


    /* shirt */

    ctx.fillStyle = "#ef4444";

    ctx.fillRect(
        5,
        15,
        23,
        8
    );


    /* arms */

    ctx.fillStyle = "#f59e0b";

    ctx.fillRect(
        0,
        19,
        7,
        13
    );

    ctx.fillRect(
        26,
        19,
        7,
        13
    );


    /* head */

    ctx.fillStyle = "#f59e0b";

    ctx.fillRect(
        7,
        5,
        20,
        18
    );


    /* hair */

    ctx.fillStyle = "#451a03";

    ctx.fillRect(
        5,
        5,
        23,
        6
    );


    /* cap */

    ctx.fillStyle = "#dc2626";

    ctx.fillRect(
        4,
        1,
        24,
        7
    );

    ctx.fillRect(
        18,
        7,
        14,
        5
    );


    /* eye */

    ctx.fillStyle = "#111827";

    ctx.fillRect(
        21,
        11,
        3,
        4
    );


    ctx.restore();

}


/* =========================================================
   DRAW GOAL
   ========================================================= */

function drawGoal() {

    const x =
        goal.x - cameraX;


    /* pole */

    ctx.fillStyle = "#e5e7eb";

    ctx.fillRect(
        x,
        goal.y,
        goal.width,
        goal.height
    );


    /* ball */

    ctx.fillStyle = "#facc15";

    ctx.beginPath();

    ctx.arc(
        x + 10,
        goal.y,
        8,
        0,
        Math.PI * 2
    );

    ctx.fill();


    /* flag */

    ctx.fillStyle = "#ef4444";

    ctx.beginPath();

    ctx.moveTo(
        x + 20,
        goal.y + 15
    );

    ctx.lineTo(
        x + 95,
        goal.y + 40
    );

    ctx.lineTo(
        x + 20,
        goal.y + 65
    );

    ctx.closePath();

    ctx.fill();


    /* base */

    ctx.fillStyle = "#64748b";

    ctx.fillRect(
        x - 20,
        goal.y + goal.height,
        60,
        12
    );

}


/* =========================================================
   PAUSE OVERLAY
   ========================================================= */

function drawPause() {

    if (!paused)
        return;


    ctx.fillStyle =
        "rgba(15,23,42,.65)";

    ctx.fillRect(
        0,
        0,
        WIDTH,
        HEIGHT
    );


    ctx.fillStyle = "white";

    ctx.font =
        "bold 55px Arial";

    ctx.textAlign = "center";

    ctx.textBaseline = "middle";

    ctx.fillText(
        "PAUSED",
        WIDTH / 2,
        HEIGHT / 2
    );

}


/* =========================================================
   DRAW
   ========================================================= */

function draw() {

    drawBackground();

    drawPlatforms();

    drawBlocks();

    drawCoins();

    drawEnemies();

    drawGoal();

    drawPlayer();

    drawPause();

}


/* =========================================================
   GAME LOOP
   ========================================================= */

function gameLoop(timestamp) {

    const delta =
        timestamp - lastTime;

    lastTime = timestamp;


    if (
        gameRunning &&
        !paused &&
        !gameOver &&
        !levelComplete
    ) {

        updatePlayer();

        updateEnemies();

        updateCoins();

        updateHUD();

    }


    draw();


    requestAnimationFrame(gameLoop);

}


/* =========================================================
   INITIALIZE
   ========================================================= */

resetWorld();

requestAnimationFrame(gameLoop);

</script>

</body>
</html>
