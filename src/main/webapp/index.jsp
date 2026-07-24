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
scroll-behavior:smooth;
}

body{

font-family:Poppins,sans-serif;
background:#05060f;
color:white;
overflow-x:hidden;

}

body::before{

content:"";
position:fixed;
width:100%;
height:100%;
background:
radial-gradient(circle at top,#1d0057,#04000d 60%);
z-index:-5;

}

.grid{

position:fixed;
width:100%;
height:100%;
background:
linear-gradient(rgba(0,255,255,.06) 1px,transparent 1px),
linear-gradient(90deg,rgba(0,255,255,.06) 1px,transparent 1px);

background-size:60px 60px;
animation:grid 8s linear infinite;
z-index:-4;

}

@keyframes grid{

100%{
transform:translateY(60px);
}

}

header{

position:fixed;
top:0;
width:100%;
display:flex;
justify-content:space-between;
align-items:center;
padding:20px 70px;
background:rgba(0,0,0,.35);
backdrop-filter:blur(15px);
z-index:999;

}

.logo{

font-family:Orbitron;
font-size:28px;
font-weight:900;
color:#00ffff;
text-shadow:0 0 20px cyan;

}

nav a{

text-decoration:none;
color:white;
margin-left:30px;
transition:.4s;

}

nav a:hover{

color:#00ffff;

}

section{

padding:120px 8%;

}

.hero{

display:flex;
align-items:center;
justify-content:space-between;
gap:60px;
min-height:100vh;

}

.hero-text{

flex:1;

}

.hero-text h1{

font-size:70px;
font-family:Orbitron;

}

.hero-text span{

color:#00ffff;
text-shadow:0 0 20px cyan;

}

.hero-text p{

margin:25px 0;
line-height:1.8;
color:#ccc;

}

button{

padding:15px 35px;
border:none;
border-radius:50px;
cursor:pointer;
margin-right:15px;
font-size:16px;
transition:.4s;

}

.primary{

background:#00ffff;
color:black;
box-shadow:0 0 25px cyan;

}

.secondary{

background:transparent;
border:2px solid magenta;
color:white;

}

button:hover{

transform:translateY(-5px);

}

.hero-image{

flex:1;

}

.hero-image img{

width:100%;
border-radius:20px;
box-shadow:0 0 40px cyan;

}

.title{

font-family:Orbitron;
font-size:45px;
text-align:center;
margin-bottom:50px;

}

.cards{

display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
gap:30px;

}

.card{

background:rgba(255,255,255,.05);
padding:20px;
border-radius:20px;
transition:.4s;

}

.card:hover{

transform:translateY(-10px);
box-shadow:0 0 30px cyan;

}

.card img{

width:100%;
height:320px;
object-fit:cover;
border-radius:15px;

}

.card h3{

margin-top:15px;
color:#00ffff;

}

.gallery{

display:grid;
grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
gap:20px;

}

.gallery img{

width:100%;
height:350px;
object-fit:cover;
border-radius:20px;
transition:.5s;

}

.gallery img:hover{

transform:scale(1.05);
box-shadow:0 0 35px cyan;

}

.about{

text-align:center;
max-width:900px;
margin:auto;
line-height:2;
font-size:18px;
color:#ddd;

}

form{

display:flex;
flex-direction:column;
max-width:600px;
margin:auto;
gap:20px;

}

input,textarea{

padding:16px;
background:#111;
border:1px solid cyan;
color:white;
border-radius:10px;

}

textarea{

height:180px;

}

footer{

padding:40px;
text-align:center;
color:#999;

}

footer a{

color:#00ffff;
text-decoration:none;
margin:0 10px;

}

@media(max-width:900px){

.hero{

flex-direction:column;
text-align:center;

}

.hero-text h1{

font-size:45px;

}

header{

padding:20px;

}

nav{

display:none;

}

}

</style>

</head>

<body>

<div class="grid"></div>

<header>

<div class="logo">UCHIHA</div>

<nav>

<a href="#home">Home</a>
<a href="#characters">Characters</a>
<a href="#gallery">Gallery</a>
<a href="#about">About</a>
<a href="#contact">Contact</a>

</nav>

</header>

<section id="home" class="hero">

<div class="hero-text">

<h1>CYBER <span>ANIME</span><br>WORLD</h1>

<p>

未来へようこそ (Welcome to the Future)

Explore the neon streets of Neo Tokyo where cyber ninjas,
AI warriors and hackers battle under endless rain.

</p>

<button class="primary"
onclick="document.getElementById('gallery').scrollIntoView()">

Explore

</button>

<button class="secondary"
onclick="document.getElementById('contact').scrollIntoView()">

Join

</button>

</div>

<div class="hero-image">

<img src="https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=900" alt="Cyberpunk City">

</div>

</section>

<section id="characters">

<h2 class="title">Elite Warriors</h2>

<div class="cards">

<div class="card">

<img src="https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=800">

<h3>Shadow Ronin</h3>

<p>Master of the Neon Blade.</p>

</div>

<div class="card">

<img src="https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800">

<h3>Cyber Oni</h3>

<p>Guardian of Neo Tokyo.</p>

</div>

<div class="card">

<img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800">

<h3>Zero Hacker</h3>

<p>The legendary AI infiltrator.</p>

</div>

</div>

</section>

<section id="gallery">

<h2 class="title">Gallery</h2>

<div class="gallery">

<img src="https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?w=800">

<img src="https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800">

<img src="https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800">

<img src="https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=800">

<img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800">

<img src="https://images.unsplash.com/photo-1511300636408-a63a89df3482?w=800">

</div>

</section>

<section id="about">

<h2 class="title">About</h2>

<div class="about">

<p>

In the year 2147 humanity merged with AI.

Mega cities glow beneath neon lights while cyber samurai,
hackers and androids fight for control of the digital world.

This website is inspired by futuristic anime aesthetics,
cyberpunk cities and Japanese culture.

</p>

</div>

</section>

<section id="contact">

<h2 class="title">Contact</h2>

<form>

<input type="text" placeholder="Your Name">

<input type="email" placeholder="Email">

<textarea placeholder="Message"></textarea>

<button class="primary">

Send Message

</button>

</form>

</section>

<footer>

<a href="#home">Home</a>

|

<a href="#characters">Characters</a>

|

<a href="#gallery">Gallery</a>

|

<a href="#about">About</a>

|

<a href="#contact">Contact</a>

<br><br>

© 2026 UCHIHA CYBERPUNK

</footer>

<script>

document.querySelectorAll("button").forEach(button=>{

button.addEventListener("mouseenter",()=>{

button.style.boxShadow="0 0 40px cyan";

});

button.addEventListener("mouseleave",()=>{

button.style.boxShadow="";

});

});

</script>

</body>
</html>
