#!/bin/bash
dnf update -y
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LuxeShop - Premium Fashion</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Segoe UI',sans-serif;line-height:1.6;color:#333}
header{background:linear-gradient(135deg,#667eea,#764ba2);color:white;padding:1rem 0;position:fixed;width:100%;top:0;z-index:1000;box-shadow:0 2px 20px rgba(0,0,0,0.1)}
nav{max-width:1200px;margin:0 auto;display:flex;justify-content:space-between;align-items:center;padding:0 2rem}
.logo{font-size:1.8rem;font-weight:bold;background:linear-gradient(45deg,#ff6b6b,#ffd93d);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.nav-links{display:flex;list-style:none;gap:2rem}
.nav-links a{color:white;text-decoration:none;transition:all 0.3s ease}
.cart-icon{font-size:1.5rem;position:relative;cursor:pointer}
.cart-count{position:absolute;top:-8px;right:-8px;background:#ff6b6b;color:white;border-radius:50%;width:20px;height:20px;display:flex;align-items:center;justify-content:center;font-size:0.8rem;font-weight:bold}
.hero{background:linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)),linear-gradient(45deg,#667eea,#764ba2);height:100vh;display:flex;align-items:center;justify-content:center;text-align:center;color:white}
.hero-content{max-width:800px;padding:2rem}
.hero h1{font-size:3rem;margin-bottom:1rem;animation:fadeInUp 1s ease-out}
.hero p{font-size:1.2rem;margin-bottom:2rem;animation:fadeInUp 1s ease-out 0.3s both}
.cta-button{display:inline-block;background:linear-gradient(45deg,#ff6b6b,#ffd93d);color:white;padding:1rem 2rem;text-decoration:none;border-radius:50px;font-weight:bold;transition:all 0.3s ease;box-shadow:0 4px 15px rgba(255,107,107,0.3);animation:fadeInUp 1s ease-out 0.6s both}
.cta-button:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(255,107,107,0.4)}
@keyframes fadeInUp{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:translateY(0)}}
.featured-products{padding:5rem 2rem;background:#f8f9fa}
.container{max-width:1200px;margin:0 auto}
.section-title{text-align:center;font-size:2.5rem;margin-bottom:3rem;color:#333;position:relative}
.section-title::after{content:'';position:absolute;bottom:-10px;left:50%;transform:translateX(-50%);width:60px;height:3px;background:linear-gradient(45deg,#ff6b6b,#ffd93d)}
.product-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:2rem;margin-top:3rem}
.product-card{background:white;border-radius:15px;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,0.1);transition:all 0.3s ease}
.product-card:hover{transform:translateY(-10px);box-shadow:0 15px 40px rgba(0,0,0,0.15)}
.product-image{height:200px;background:linear-gradient(45deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;color:white;font-size:3rem}
.product-info{padding:1.5rem}
.product-title{font-size:1.3rem;font-weight:bold;margin-bottom:0.5rem;color:#333}
.product-price{font-size:1.5rem;font-weight:bold;color:#ff6b6b;margin-bottom:1rem}
.product-description{color:#666;margin-bottom:1.5rem}
.add-to-cart{background:linear-gradient(45deg,#667eea,#764ba2);color:white;border:none;padding:0.8rem 1.5rem;border-radius:25px;font-weight:bold;cursor:pointer;transition:all 0.3s ease;width:100%}
.add-to-cart:hover{transform:translateY(-2px);box-shadow:0 5px 15px rgba(102,126,234,0.3)}
.features{padding:5rem 2rem;background:white}
.features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem;margin-top:3rem}
.feature-card{text-align:center;padding:2rem}
.feature-icon{font-size:3rem;margin-bottom:1rem;background:linear-gradient(45deg,#ff6b6b,#ffd93d);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.feature-title{font-size:1.5rem;font-weight:bold;margin-bottom:1rem;color:#333}
.feature-description{color:#666}
footer{background:#333;color:white;padding:3rem 2rem 1rem;text-align:center}
.footer-content{max-width:1200px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem;margin-bottom:2rem}
.footer-section h3{margin-bottom:1rem;color:#ffd93d}
.footer-section p,.footer-section a{color:#ccc;text-decoration:none;line-height:1.8}
.social-icons{display:flex;justify-content:center;gap:1rem;margin-top:1rem}
.social-icons a{display:flex;align-items:center;justify-content:center;width:40px;height:40px;background:linear-gradient(45deg,#667eea,#764ba2);border-radius:50%;color:white;transition:all 0.3s ease}
.social-icons a:hover{transform:translateY(-2px)}
@media (max-width:768px){.nav-links{display:none}.hero h1{font-size:2rem}.product-grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<header>
<nav>
<div class="logo">LuxeShop</div>
<ul class="nav-links">
<li><a href="#home">Home</a></li>
<li><a href="#products">Products</a></li>
<li><a href="#about">About</a></li>
</ul>
<div class="cart-icon">
<i class="fas fa-shopping-cart"></i>
<span class="cart-count" id="cart-count">0</span>
</div>
</nav>
</header>

<section class="hero" id="home">
<div class="hero-content">
<h1>Discover Luxury Fashion</h1>
<p>Elevate your style with our curated collection of premium fashion and lifestyle products.</p>
<a href="#products" class="cta-button">Shop Now</a>
</div>
</section>

<section class="featured-products" id="products">
<div class="container">
<h2 class="section-title">Featured Products</h2>
<div class="product-grid">
<div class="product-card">
<div class="product-image"><i class="fas fa-tshirt"></i></div>
<div class="product-info">
<h3 class="product-title">Premium Cotton T-Shirt</h3>
<p class="product-price">$89.99</p>
<p class="product-description">Ultra-soft premium cotton with modern fit.</p>
<button class="add-to-cart" onclick="addToCart()">Add to Cart</button>
</div>
</div>

<div class="product-card">
<div class="product-image"><i class="fas fa-gem"></i></div>
<div class="product-info">
<h3 class="product-title">Luxury Watch</h3>
<p class="product-price">$299.99</p>
<p class="product-description">Elegant timepiece with Swiss movement.</p>
<button class="add-to-cart" onclick="addToCart()">Add to Cart</button>
</div>
</div>

<div class="product-card">
<div class="product-image"><i class="fas fa-shoe-prints"></i></div>
<div class="product-info">
<h3 class="product-title">Designer Sneakers</h3>
<p class="product-price">$159.99</p>
<p class="product-description">Comfortable premium sneakers.</p>
<button class="add-to-cart" onclick="addToCart()">Add to Cart</button>
</div>
</div>
</div>
</div>
</section>

<section class="features" id="about">
<div class="container">
<h2 class="section-title">Why Choose LuxeShop?</h2>
<div class="features-grid">
<div class="feature-card">
<div class="feature-icon"><i class="fas fa-shipping-fast"></i></div>
<h3 class="feature-title">Fast Shipping</h3>
<p class="feature-description">Free shipping on orders over $50.</p>
</div>
<div class="feature-card">
<div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
<h3 class="feature-title">Quality Guarantee</h3>
<p class="feature-description">30-day money-back guarantee.</p>
</div>
<div class="feature-card">
<div class="feature-icon"><i class="fas fa-headset"></i></div>
<h3 class="feature-title">24/7 Support</h3>
<p class="feature-description">Customer support available.</p>
</div>
</div>
</div>
</section>

<footer>
<div class="footer-content">
<div class="footer-section">
<h3>LuxeShop</h3>
<p>Premium fashion and lifestyle products.</p>
<div class="social-icons">
<a href="#"><i class="fab fa-facebook-f"></i></a>
<a href="#"><i class="fab fa-twitter"></i></a>
<a href="#"><i class="fab fa-instagram"></i></a>
</div>
</div>
<div class="footer-section">
<h3>Contact</h3>
<p>info@luxeshop.com</p>
<p>+1 (555) 123-4567</p>
</div>
</div>
<div style="border-top:1px solid #555;padding-top:1rem;color:#999">
<p>&copy; 2025 LuxeShop. Deployed on AWS EC2</p>
</div>
</footer>

<script>
let cartCount = 0;
function addToCart() {
cartCount++;
document.getElementById('cart-count').textContent = cartCount;
alert('Added to cart! Total items: ' + cartCount);
}

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
anchor.addEventListener('click', function (e) {
e.preventDefault();
const target = document.querySelector(this.getAttribute('href'));
if (target) {
target.scrollIntoView({behavior: 'smooth'});
}
});
});

window.addEventListener('scroll', () => {
const header = document.querySelector('header');
if (window.scrollY > 100) {
header.style.background = 'rgba(102, 126, 234, 0.95)';
} else {
header.style.background = 'linear-gradient(135deg, #667eea, #764ba2)';
}
});
</script>
</body>
</html>
EOF

chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

firewall-cmd --permanent --add-service=http 2>/dev/null || true
firewall-cmd --reload 2>/dev/null || true

systemctl restart httpd

echo "🎉 LuxeShop deployed! Access at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo 'YOUR_EC2_IP')"