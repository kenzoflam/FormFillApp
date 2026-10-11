<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello Harshal - How are you feeling today ? </title>
  <style>
    :root {
      --sky: #65d8ff;
      --ink: #182044;
      --red: #ff4c54;
      --yellow: #ffd447;
      --green: #48c774;
      --cream: #fff8df;
    }
    * { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body {
      margin: 0;
      color: var(--ink);
      font-family: "Courier New", monospace;
      background: var(--cream);
    }
    .topbar {
      display: flex; align-items: center; justify-content: space-between;
      gap: 18px; padding: 18px clamp(18px, 5vw, 72px);
      background: #fffdf4; border-bottom: 4px solid var(--ink);
    }
    .brand { font-weight: 900; font-size: clamp(18px, 2vw, 25px); letter-spacing: -1px; }
    .brand span { color: var(--red); }
    .nav { display: flex; gap: 22px; flex-wrap: wrap; }
    .nav a { color: var(--ink); text-decoration: none; font-weight: 900; font-size: 13px; }
    .nav a:hover { color: #e63748; }
    .hero {
      position: relative; overflow: hidden; min-height: 640px;
      display: flex; align-items: center; justify-content: center;
      padding: 70px 20px 140px; text-align: center;
      background: linear-gradient(#65d8ff 0%, #a4edff 70%, #d9f8ff 100%);
      border-bottom: 6px solid var(--ink);
      isolation: isolate;
    }
    .sun {
      position: absolute; width: 90px; height: 90px; border-radius: 50%;
      background: var(--yellow); top: 60px; right: 13%; box-shadow: 0 0 0 10px #ffd44755;
    }
    .cloud {
      position: absolute; width: 100px; height: 28px; border: 4px solid var(--ink);
      background: white; border-radius: 20px; box-shadow: 4px 4px 0 #18204422;
    }
    .cloud:before, .cloud:after {
      content: ""; position: absolute; bottom: 7px; background: white;
      border: 4px solid var(--ink); border-bottom: 0; border-radius: 30px 30px 0 0;
    }
    .cloud:before { left: 13px; width: 30px; height: 25px; }
    .cloud:after { left: 42px; width: 35px; height: 34px; }
    .cloud.one { top: 110px; left: 9%; }
    .cloud.two { top: 205px; right: 10%; transform: scale(.75); }
    .cloud.three { top: 65px; left: 43%; transform: scale(.55); }
    .hero-content { position: relative; z-index: 2; max-width: 760px; }
    .eyebrow {
      display: inline-block; background: white; border: 3px solid var(--ink);
      padding: 9px 13px; font-size: 12px; font-weight: 900;
      box-shadow: 5px 5px 0 var(--ink); transform: rotate(-2deg);
    }
    h1 {
      margin: 25px 0 14px; font-size: clamp(42px, 8vw, 86px);
      line-height: .96; letter-spacing: -5px; font-weight: 1000;
      text-shadow: 4px 4px 0 white, 8px 8px 0 var(--ink);
    }
    h1 .pixel { color: var(--red); }
    .lead { max-width: 520px; margin: 26px auto; font-size: 16px; line-height: 1.7; font-weight: 700; }
    .buttons { display: flex; justify-content: center; gap: 14px; flex-wrap: wrap; }
    .btn {
      display: inline-block; border: 4px solid var(--ink); padding: 15px 22px;
      font: 900 14px "Courier New", monospace; text-decoration: none; color: var(--ink);
      background: var(--yellow); box-shadow: 6px 6px 0 var(--ink);
      cursor: pointer; transition: transform .12s, box-shadow .12s;
    }
    .btn:hover { transform: translate(3px, 3px); box-shadow: 3px 3px 0 var(--ink); }
    .btn.secondary { background: white; }
    .world {
      position: absolute; z-index: 1; bottom: 0; left: 0; right: 0; height: 118px;
      background: #8be05a; border-top: 6px solid var(--ink);
    }
    .world:before {
      content: ""; position: absolute; top: 22px; left: 0; right: 0; height: 15px;
      background: repeating-linear-gradient(90deg, #4abf4f 0 28px, #69d957 28px 56px);
    }
    .ground {
      position: absolute; bottom: 0; height: 48px; left: 0; right: 0;
      border-top: 5px solid var(--ink);
      background-color: #b86a3c;
      background-image: linear-gradient(90deg, transparent 46px, #182044 47px, #182044 51px, transparent 52px),
                        linear-gradient(#182044 4px, transparent 4px);
      background-size: 64px 25px;
    }
    .pipe {
      position: absolute; bottom: 48px; right: 15%; width: 76px; height: 92px;
      background: #36c65b; border: 5px solid var(--ink); border-bottom: 0;
      box-shadow: inset 10px 0 #ffffff30;
    }
    .pipe:before {
      content: ""; position: absolute; top: -17px; left: -12px; width: 90px; height: 20px;
      background: #4be36d; border: 5px solid var(--ink);
    }
    .brick {
      position: absolute; bottom: 190px; width: 47px; height: 47px;
      border: 4px solid var(--ink); background: #f29a42;
      box-shadow: inset 0 0 0 4px #ffc16c;
    }
    .brick:after { content: ""; position: absolute; left: 0; right: 0; top: 18px; border-top: 4px solid #182044; }
    .brick.b1 { left: 14%; }
    .brick.b2 { left: calc(14% + 47px); }
    .question {
      position: absolute; bottom: 255px; left: calc(14% + 47px);
      width: 48px; height: 48px; display: grid; place-items: center;
      color: var(--ink); font-weight: 1000; font-size: 27px;
      background: var(--yellow); border: 4px solid var(--ink);
      box-shadow: inset 0 0 0 4px #fff0a4, 4px 4px 0 #18204455;
    }
    .coin {
      position: absolute; width: 24px; height: 34px; bottom: 235px;
      left: 34%; border: 4px solid var(--ink); border-radius: 50%;
      background: var(--yellow); box-shadow: inset 4px 0 #fff0a4;
      animation: bob 1.3s ease-in-out infinite alternate;
    }
    .coin.c2 { left: 38%; bottom: 275px; animation-delay: .3s; }
    .coin.c3 { left: 42%; bottom: 235px; animation-delay: .6s; }
    @keyframes bob { from { transform: translateY(0); } to { transform: translateY(-10px); } }
    .tiny-hero {
      position: absolute; z-index: 3; bottom: 46px; left: 25%;
      width: 42px; height: 53px; background: #ffcf9c;
      border: 4px solid var(--ink); box-shadow: inset 0 -13px #3775e8;
      transition: left .15s, bottom .15s;
    }
    .tiny-hero:before {
      content: ""; position: absolute; left: -5px; top: -13px; width: 35px; height: 13px;
      background: var(--red); border: 4px solid var(--ink);
    }
    .tiny-hero:after {
      content: ""; position: absolute; right: 3px; top: 8px; width: 6px; height: 6px; background: var(--ink);
    }
    .section { padding: 75px 20px; max-width: 1100px; margin: auto; }
    .section-heading { text-align: center; font-size: clamp(25px, 4vw, 38px); margin: 0 0 12px; }
    .section-sub { text-align: center; line-height: 1.6; margin: 0 auto 36px; max-width: 600px; }
    .cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
    .card {
      background: white; border: 4px solid var(--ink); padding: 25px;
      box-shadow: 7px 7px 0 var(--ink); min-height: 190px;
    }
    .card .emoji { font-size: 35px; }
    .card h3 { margin: 15px 0 9px; font-size: 17px; }
    .card p { margin: 0; font-size: 13px; line-height: 1.7; }
    .play-panel {
      background: #fff; border: 4px solid var(--ink); box-shadow: 8px 8px 0 var(--ink);
      padding: 28px; max-width: 680px; margin: 0 auto; text-align: center;
    }
    .hud { display: flex; justify-content: space-around; gap: 12px; flex-wrap: wrap; font-weight: 900; margin-bottom: 20px; }
    .mini-stage {
      height: 130px; position: relative; overflow: hidden; background: #8ee4ff;
      border: 4px solid var(--ink); margin-bottom: 22px;
    }
    .mini-stage .mini-ground { position: absolute; height: 28px; bottom: 0; left: 0; right: 0; background: #a65b36; border-top: 4px solid var(--ink); }
    .mini-stage .mini-player { position: absolute; left: 15%; bottom: 28px; width: 26px; height: 36px; background: var(--red); border: 3px solid var(--ink); transition: left .12s, bottom .12s; }
    .mini-stage .mini-player:after { content: ""; position: absolute; top: 10px; left: 12px; width: 4px; height: 4px; background: var(--ink); }
    .mini-stage .mini-coin { position: absolute; top: 30px; left: 60%; color: #d79a00; font-size: 26px; }
    .controls { display: flex; justify-content: center; gap: 10px; flex-wrap: wrap; }
    .controls .btn { padding: 10px 15px; min-width: 62px; }
    #game-message { min-height: 22px; margin-top: 18px; font-size: 12px; font-weight: 900; }
    footer { text-align: center; padding: 27px 20px; background: var(--ink); color: white; font-size: 12px; line-height: 1.8; }
    @media (max-width: 700px) {
      .topbar { align-items: flex-start; flex-direction: column; }
      .hero { min-height: 600px; }
      .cards { grid-template-columns: 1fr; }
      h1 { letter-spacing: -3px; }
      .pipe { right: 7%; transform: scale(.8); transform-origin: bottom right; }
      .brick.b1 { left: 7%; } .brick.b2 { left: calc(7% + 47px); }
      .question { left: calc(7% + 47px); }
      .tiny-hero { left: 25%; }
    }
  </style>
</head>
<body>
  <header class="topbar">
    <div class="brand">PIXEL<span>QUEST</span> ★</div>
    <nav class="nav" aria-label="Main navigation">
      <a href="#features">THE WORLD</a>
      <a href="#play">PLAY DEMO</a>
      <a href="#controls">CONTROLS</a>
    </nav>
  </header>

  <main>
    <section class="hero" aria-labelledby="hero-title">
      <div class="sun"></div>
      <div class="cloud one"></div><div class="cloud two"></div><div class="cloud three"></div>
      <div class="brick b1"></div><div class="brick b2"></div><div class="question">?</div>
      <div class="coin"></div><div class="coin c2"></div><div class="coin c3"></div>
      <div class="tiny-hero" id="hero-player" aria-hidden="true"></div>
      <div class="hero-content">
        <span class="eyebrow">★ INSERT COIN TO BEGIN ★</span>
        <h1 id="hero-title">PIXEL <span class="pixel">QUEST</span></h1>
        <p class="lead">A tiny retro adventure packed with golden coins, mystery blocks, and big 8-bit energy. Your next great quest starts here!</p>
        <div class="buttons">
          <a class="btn" href="#play">▶ PLAY THE DEMO</a>
          <a class="btn secondary" href="#features">EXPLORE WORLD ↓</a>
        </div>
      </div>
      <div class="pipe"></div>
      <div class="world"><div class="ground"></div></div>
    </section>

    <section class="section" id="features">
      <h2 class="section-heading">A WORLD OF PIXEL MAGIC</h2>
      <p class="section-sub">Jump into a bright little world inspired by the golden age of platform games.</p>
      <div class="cards">
        <article class="card"><div class="emoji">🪙</div><h3>COLLECT THE LOOT</h3><p>Grab shiny coins, chase your high score, and see how many treasures you can find.</p></article>
        <article class="card"><div class="emoji">🧱</div><h3>HIDDEN SURPRISES</h3><p>Every block might hold a surprise. Explore, jump around, and keep wondering what's next.</p></article>
        <article class="card"><div class="emoji">🎮</div><h3>OLD-SCHOOL FUN</h3><p>Chunky pixel art, bright colors, and simple controls bring arcade nostalgia to your browser.</p></article>
      </div>
    </section>

    <section class="section" id="play">
      <h2 class="section-heading">READY, PLAYER ONE?</h2>
      <p class="section-sub">Try this tiny keyboard demo. Collect the coin and make your little pixel hero move!</p>
      <div class="play-panel">
        <div class="hud"><span>PLAYER 1</span><span>COINS: <span id="coin-count">00</span></span><span>LIVES: ♥ ♥ ♥</span></div>
        <div class="mini-stage" id="mini-stage" aria-label="Mini game area">
          <div class="mini-coin" id="mini-coin">●</div>
          <div class="mini-player" id="mini-player"></div>
          <div class="mini-ground"></div>
        </div>
        <div class="controls" id="controls">
          <button class="btn" id="left-btn" type="button">← LEFT</button>
          <button class="btn" id="jump-btn" type="button">↑ JUMP</button>
          <button class="btn" id="right-btn" type="button">RIGHT →</button>
          <button class="btn secondary" id="reset-btn" type="button">↻ RESET</button>
        </div>
        <div id="game-message" role="status">Use ← → to move and SPACE or ↑ to jump.</div>
      </div>
    </section>
  </main>

  <footer>
    <strong>PIXEL QUEST</strong> · A little tribute to classic 8-bit platform adventures.<br>
    Original fan-inspired demo concept; not affiliated with Nintendo or any existing game franchise.
  </footer>

  <script>
    (() => {
      const player = document.getElementById('mini-player');
      const stage = document.getElementById('mini-stage');
      const coin = document.getElementById('mini-coin');
      const count = document.getElementById('coin-count');
      const message = document.getElementById('game-message');
      const hero = document.getElementById('hero-player');
      let x = 15, y = 0, coins = 0, jumping = false, collected = false;
      function draw() {
        const maxX = Math.max(0, stage.clientWidth - player.offsetWidth - 8);
        x = Math.max(0, Math.min(x, maxX / stage.clientWidth * 100));
        player.style.left = x + '%';
        player.style.bottom = (28 + y) + 'px';
        coin.style.display = collected ? 'none' : 'block';
        count.textContent = String(coins).padStart(2, '0');
        const playerCenter = (x / 100) * stage.clientWidth + player.offsetWidth / 2;
        if (!collected && playerCenter > stage.clientWidth * .54 && playerCenter < stage.clientWidth * .72 && y > 0) {
          collected = true; coins++; message.textContent = 'NICE! You collected a coin. Keep exploring!';
          draw();
        }
      }
      function move(direction) { x += direction * 5; draw(); }
      function jump() {
        if (jumping) return;
        jumping = true; y = 55; draw();
        setTimeout(() => { y = 0; jumping = false; draw(); }, 420);
      }
      document.getElementById('left-btn').addEventListener('click', () => move(-1));
      document.getElementById('right-btn').addEventListener('click', () => move(1));
      document.getElementById('jump-btn').addEventListener('click', jump);
      document.getElementById('reset-btn').addEventListener('click', () => {
        x = 15; y = 0; coins = 0; collected = false; jumping = false;
        message.textContent = 'Use ← → to move and SPACE or ↑ to jump.'; draw();
      });
      document.addEventListener('keydown', e => {
        if (['ArrowLeft','ArrowRight','ArrowUp',' '].includes(e.key)) e.preventDefault();
        if (e.key === 'ArrowLeft') move(-1);
        if (e.key === 'ArrowRight') move(1);
        if (e.key === 'ArrowUp' || e.key === ' ') jump();
      });
      let heroX = 25;
      document.addEventListener('keydown', e => {
        if (e.key === 'ArrowLeft') heroX = Math.max(4, heroX - 2);
        if (e.key === 'ArrowRight') heroX = Math.min(75, heroX + 2);
        hero.style.left = heroX + '%';
      });
      window.addEventListener('resize', draw);
      draw();
    })();
  </script>
</body>
</html>
