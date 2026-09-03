<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UCHIHA CYBERPUNK</title>

<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{

font-family:Poppins,sans-serif;
background:#05060f;
overflow-x:hidden;
color:white;

}

body::before{

content:'';
position:fixed;
width:100%;
height:100%;
background:
radial-gradient(circle at top,#1d0057,#04000d 60%);
z-index:-3;

}

.grid{

position:fixed;
width:100%;
height:100%;
background:
linear-gradient(rgba(0,255,255,.08) 1px,transparent 1px),
linear-gradient(90deg,rgba(0,255,255,.08) 1px,transparent 1px);
background-size:60px 60px;
animation:gridMove 8s linear infinite;
z-index:-2;

}

@keyframes gridMove{

0%{
transform:translateY(0);
}

100%{
transform:translateY(60px);
}

}

.neon{

position:fixed;
width:100%;
height:100%;
overflow:hidden;
z-index:-1;

}

.circle{

position:absolute;
border-radius:50%;
filter:blur(80px);

}

.c1{

width:350px;
height:350px;
background:#00ffff;
left:-100px;
top:10%;

}

.c2{

width:300px;
height:300px;
background:#ff00ff;
right:-100px;
bottom:10%;

}

header{

display:flex;
justify-content:space-between;
align-items:center;
padding:25px 80px;
position:fixed;
width:100%;
background:rgba(0,0,0,.3);
backdrop-filter:blur(15px);
z-index:999;

}

.logo{

font-family:Orbitron;
font-size:30px;
font-weight:900;
color:#00ffff;
text-shadow:0 0 20px cyan;

}

nav a{

text-decoration:none;
margin-left:40px;
color:white;
transition:.4s;

}

nav a:hover{

color:#00ffff;
text-shadow:0 0 20px cyan;

}

.hero{

height:100vh;
display:flex;
justify-content:center;
align-items:center;
padding:0 8%;
gap:70px;

}

.left{

flex:1;

}

.left h1{

font-family:Orbitron;
font-size:70px;
line-height:1.1;
margin-bottom:25px;

}

.left h1 span{

color:#00ffff;
text-shadow:0 0 20px cyan;

}

.jp{

font-size:22px;
color:#ff00ff;
margin-bottom:20px;

}

.left p{

color:#bbb;
line-height:1.8;
font-size:18px;

}

.buttons{

margin-top:40px;

}

button{

padding:16px 40px;
border:none;
margin-right:20px;
cursor:pointer;
font-size:17px;
border-radius:40px;
transition:.4s;

}

.primary{

background:#00ffff;
color:black;
box-shadow:0 0 30px cyan;

}

.primary:hover{

transform:translateY(-5px);
box-shadow:0 0 50px cyan;

}

.secondary{

background:transparent;
border:2px solid magenta;
color:white;

}

.secondary:hover{

background:magenta;
box-shadow:0 0 40px magenta;

}

.right{

flex:1;
display:flex;
justify-content:center;

}

.card{

width:430px;
height:560px;
background:rgba(255,255,255,.06);
backdrop-filter:blur(25px);
border:1px solid rgba(255,255,255,.15);
border-radius:25px;
overflow:hidden;
box-shadow:0 0 40px rgba(0,255,255,.25);
transition:.5s;

}

.card:hover{

transform:translateY(-10px);
box-shadow:0 0 60px cyan;

}

.card img{

width:100%;
height:100%;
object-fit:cover;

}

.section{

padding:120px 10%;

}

.title{

text-align:center;
font-family:Orbitron;
font-size:45px;
margin-bottom:70px;

}

.cards{

display:grid;
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
gap:35px;

}

.box{

padding:35px;
background:rgba(255,255,255,.05);
border:1px solid rgba(255,255,255,.08);
border-radius:20px;
transition:.4s;

}

.box:hover{

transform:translateY(-10px);
box-shadow:0 0 40px cyan;

}

.box h3{

color:#00ffff;
margin-bottom:15px;

}

footer{

text-align:center;
padding:40px;
color:#888;

}

@media(max-width:900px){

.hero{

flex-direction:column;
padding-top:120px;

}

.left h1{

font-size:48px;

}

header{

padding:20px;

}

nav{

display:none;

}

.card{

width:90%;
height:500px;

}

}

</style>

</head>
<body>

<div class="grid"></div>

<div class="neon">
<div class="circle c1"></div>
<div class="circle c2"></div>
</div>

<header>

<div class="logo">UCHIHA</div>

<nav>

<a href="#">Home</a>
<a href="#">Characters</a>
<a href="#">Gallery</a>
<a href="#">Universe</a>
<a href="#">Contact</a>

</nav>

</header>

<section class="hero">

<div class="left">

<div class="jp">未来へようこそ • Welcome to the Future</div>

<h1>
CYBER <span>ANIME</span><br>
WORLD
</h1>

<p>

Enter a futuristic world filled with neon lights,
legendary warriors, cybernetic cities and limitless
technology.

Experience anime like never before.

</p>

<div class="buttons">

<button class="primary">Explore</button>
<button class="secondary">Join Now</button>

</div>

</div>

<div class="right">

<div class="card">

<img src="https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?auto=format&fit=crop&w=900&q=80">

</div>

</div>

</section>

<section class="section">

<div class="title">CYBER FEATURES</div>

<div class="cards">

<div class="box">

<h3>⚡ Neon City</h3>

<p>
Explore futuristic Japanese cities with glowing
streets and cyberpunk architecture.
</p>

</div>

<div class="box">

<h3>🤖 Android Warriors</h3>

<p>
Fight beside AI enhanced anime warriors equipped
with advanced technology.
</p>

</div>

<div class="box">

<h3>🎮 Virtual Universe</h3>

<p>
Travel through digital realities inspired by
classic cyberpunk anime.
</p>

</div>

<div class="box">

<h3>🌌 Infinite Power</h3>

<p>
Unlock legendary powers and become the strongest
cyber ninja.
</p>

</div>

</div>

</section>

<footer>

© 2026 UCHIHA CYBERPUNK | 未来はここにある

</footer>

<script>

document.querySelectorAll("button").forEach(btn=>{

btn.addEventListener("mousemove",e=>{

btn.style.boxShadow="0 0 60px cyan";

})

btn.addEventListener("mouseleave",e=>{

btn.style.boxShadow="";

})

})

</script>

</body>
</html>
