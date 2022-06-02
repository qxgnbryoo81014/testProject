// import logo from './logo.svg';
import './App.css';
import LoginFooter from './components/test';

function App() {

//   main.js 依據 data-bg-image載入背景(不確定這邊怎麼做，直接寫入css-style)

//   $('[data-bg-image]').each(function () {
//     var $this = $(this),
//         $image = $this.data('bg-image');
//     $this.css('background-image', 'url(' + $image + ')');
// });
  console.log("wtf app.js");
  return (
    <div className="App">
      <header className="App-header">

      

        <div className="header-section section bg-white d-none d-xl-block">
          <div className="container">
            <div className="row row-cols-lg-3 align-items-center">
              <div className="col">
                <div className="header-logo">
                  <a href="index.html"><img src="./images/web logo1.png" alt="studio4art Logo" /></a>
                </div>
              </div>
              <div className="col">
                <nav className="site-main-menu menu-height-100 justify-content-center">
                  <ul>
                    <li className="has-children"><a href="https://aws.amazon.com/tw/"><span className="menu-text">商品專區</span></a>
                      <ul className="sub-menu">
                        <li><a href="shoptest.jsp"><span className="menu-text">全部商品</span></a></li>
                        <li><a href="shop11.jsp"><span className="menu-text">手繪瓷盤</span></a></li>
                        <li><a href="shop22.jsp"><span className="menu-text">電烙畫</span></a></li>
                        <li><a href="shop33.jsp"><span className="menu-text">釉燒陶</span></a></li>
                        <li><a href="shop33.jsp"><span className="menu-text">彩色鉛筆</span></a></li>
                        <li><a href="shop33.jsp"><span className="menu-text">水彩</span></a></li>
                        <li><a href="shop33.jsp"><span className="menu-text">壓克力彩繪</span></a></li>
                      </ul>
                    </li>

                    <li className="has-children"><a href="https://aws.amazon.com/tw/"><span className="menu-text">手作課程</span></a>
                      <ul className="sub-menu">
                        <li><a href="courseList.html"><span className="menu-text">報名課程</span></a></li>
                      </ul>
                    </li>
                    <li className="has-children"><a href="https://aws.amazon.com/tw/"><span className="menu-text">關於我們</span></a>
                      <ul className="sub-menu">
                        <li><a href="about-us.html"><span className="menu-text">關於studio4art</span></a></li>
                      </ul>
                    </li>
                  </ul>
                </nav>
              </div>

              {/* <!-- Header Tools (header icon) Start --> */}
              <div className="col">
                <div className="header-tools justify-content-end">
                  <div className="header-login">
                    <a href="login-register.html"><i className="fal fa-user"></i></a>
                  </div>

                  <div className="header-wishlist">
                    <a href="#offcanvas-wishlist" className="offcanvas-toggle"><span className="wishlist-count">0</span><i className="fal fa-heart"></i></a>
                  </div>
                  <div className="header-cart">
                    <a href="#offcanvas-cart" className="offcanvas-toggle"><span className="cart-count">0</span><i className="fal fa-shopping-cart"></i></a>
                  </div>
                </div>
              </div>
              {/* <!-- Header Tools (header icon) End --> */}
            </div>
          </div>
        </div>

        {/* <!-- Slider main container Start --> */}
        <div className="home1-slider swiper-container">
          <div className="swiper-wrapper">
            <div className="home1-slide-item swiper-slide" data-swiper-autoplay="5000" style={{backgroundImage:`url("images/slider/home1/index_banner5.png")`}} data-bg-image>
              <div className="home1-slide1-content">
                <span className="bg" style={{backgroundImage:`url("images/slider/home1/slide-2-1.webp")`}} data-bg-image></span>
                <span className="slide-border"></span>
                <span className="icon"><img src="./images/slider/home1/art.png" width="100" height="100" alt="Slide Icon" /></span>
                <h2 className="title">Color Pencil </h2>
                <h2 className="title">Drawing</h2>
                <h3 className="sub-title"> </h3>
                <div className="link"><a href="shoptest.jsp">LEARN MORE</a></div>
              </div>
            </div>
            <div className="home1-slide-item swiper-slide" data-swiper-autoplay="5000" style={{backgroundImage:`url("images/slider/home1/index_banner4.jpg")`}} data-bg-image>
              <div className="home1-slide2-content">
                <span className="bg" style={{backgroundImage:`url("images/slider/home1/slide-2-1.webp")`}} data-bg-image></span>
                <span className="slide-border"></span>
                {/* <span className="icon"> */}

                <img src="./images/slider/home1/slide-2-2.webp" alt="Slide Icon" />
                <img src="./images/slider/home1/slide-2-3.webp" alt="Slide Icon" />
                {/* </span> */}

                <h3 className="sub-title"> IN PERSON CLASSES </h3>
                <div className="link"><a href="courseList.html">親 自 教 學</a></div>

                <div className="link"><a href="courseList.html">LEARN MORE</a></div>
              </div>
            </div>
            <div className="home1-slide-item swiper-slide" data-swiper-autoplay="5000" style={{backgroundImage:`url("images/slider/home1/index_banner2.png")`}} data-bg-image> </div>
          </div>
          <div className="home1-slider-prev swiper-button-prev"><i className="ti-angle-left"></i></div>
          <div className="home1-slider-next swiper-button-next"><i className="ti-angle-right"></i></div>
        </div>
        {/* <!-- Slider main container End --> */}

        {/* <!-- Sale Banner Section Start --> */}
        <div className="section section-padding">
          <div className="container">

            {/* <!-- Section Title Start --> */}
            <div className="section-title text-center">
              <h3 className="sub-title">測試</h3>
              <h2 className="title title-icon-both">Making & crafting</h2>
            </div>
            {/* <!-- Section Title End --> */}

            <div className="row learts-mb-n40">

              <div className="col-lg-5 col-md-6 col-12 me-auto learts-mb-40">
                <div className="sale-banner1" style={{backgroundImage:`url("images/banner/sale/sale-banner1-1.webp")`}} data-bg-image>
                  <div className="inner">

                    <h2 className="sale-percent">手作藝品</h2>
                    <h2 className="sale-percent">客製化 </h2>
                    <h2 className="sale-percent">體驗課程 </h2>
                    <img src="./images/banner/sale/sale-banner1-1.1.webp" alt="Sale Banner Icon" />

                  </div>
                </div>
              </div>

              <div className="col-lg-6 col-md-6 col-12 learts-mb-40">
                <div className="sale-banner2">
                  <div className="inner">
                    <div className="image"><img src="./images/banner/sale/in_person_classes2.PNG" alt="" /></div>
                    <div className="content row justify-content-between mb-n3">
                      <div className="col-auto mb-3">
                        <h2 className="sale-percent">親 自 教 學</h2>
                        <span className="text">IN PERSON CLASSES</span>
                      </div>
                      <div className="col-auto mb-3">
                        <a className="btn btn-hover-dark" href="courseList.html">LEARN MORE</a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>
        {/* <!-- Sale Banner Section End --> */}

        {/* <!-- Section Title Start --> */}
        <div className="section-title text-center">
          <h3 className="sub-title">Shop now</h3>
          <h2 className="title title-icon-both">Shop our best-sellers</h2>
        </div>
        {/* <!-- Section Title End --> */}

        {/* <!-- Category Banner Section Start --> */}
        <div className="section section-fluid section-padding pt-0">
          <div className="container">
            <div className="category-banner1-carousel">

              <div className="col">
                <div className="category-banner1">
                  <div className="inner">
                    <a href="shop11.jsp" className="image"><img src="./images/banner/category/cat_plant.jpg" width="525px" height="270px" alt="img desc" /></a>
                    <div className="content">
                      <h3 className="title">
                        <a href="shop11.jsp">手繪瓷盤</a>
                        <span className="number">3</span>
                      </h3>
                    </div>
                  </div>
                </div>
              </div>

              <div className="col">
                <div className="category-banner1">
                  <div className="inner">
                    <a href="shop44.jsp" className="image"><img src="./images/banner/category/colorpencil_cartoon2.jpg" width="525px" height="270px" alt="img desc" /></a>
                    <div className="content">
                      <h3 className="title">
                        <a href="shop44.jsp">彩色鉛筆Q版畫</a>
                        <span className="number">5</span>
                      </h3>
                    </div>
                  </div>
                </div>
              </div>

              <div className="col">
                <div className="category-banner1">
                  <div className="inner">
                    <a href="shop66.jsp" className="image"><img src="./images/banner/category/acrylic painting2.jpg" width="525px" height="270px" alt="img desc" /></a>
                    <div className="content">
                      <h3 className="title">
                        <a href="shop66.jsp">壓克力彩繪</a>
                        <span className="number">6</span>
                      </h3>
                    </div>
                  </div>
                </div>
              </div>

              <div className="col">
                <div className="category-banner1">
                  <div className="inner">
                    <a href="shop22.jsp" className="image"><img src="./images/banner/category/fox_woodburn.jpg" width="525px" height="270px" alt="img desc" /></a>
                    <div className="content">
                      <h3 className="title">
                        <a href="shop22.jsp">電烙木版畫</a>
                        <span className="number">2</span>
                      </h3>
                    </div>
                  </div>
                </div>
              </div>

              <div className="col">
                <div className="category-banner1">
                  <div className="inner">
                    <a href="shop33.jsp" className="image"><img src="./images/banner/category/pottery_doll.jpg" width="525px" height="270px" alt="img desc" /></a>
                    <div className="content">
                      <h3 className="title">
                        <a href="shop33.jsp">陶製藝品</a>
                        <span className="number">4</span>
                      </h3>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>
        {/* <!-- Category Banner Section End --> */}

        {/* <!-- Product Tab End --> */}

        <div className="row learts-mt-0">
          <div className="col text-center">
            <a href="shoptest.jsp" className="btn p-0"><i className="ti-plus"></i> load more ...</a>

          </div>
        </div>
        {/* <!-- Product Section End --> */}
        <div className="row g-0 justify-content-center learts-mt-50">
          <a href="https://aws.amazon.com/tw/" className="btn p-0"><i className=""></i></a>
        </div>

        {/* <!-- Separator --> 
      <div className="section">
          <div className="container">
              <hr className="m-0"/>
          </div>
      </div>
  
  
      <div className="section">
          <div className="container">
              <hr className="m-0"/>
          </div>
      </div>
      */}



        {/* <!-- Gallery Section Start --> */}
        
        <LoginFooter showStar='wtf star'/>

        <div className="section section-padding pt-0">
          <div className="container">
            <div className="row row-cols-lg-2 row-cols-1 learts-mb-n50">

              <div className="col align-self-center learts-mb-50 order-lg-2">
                <div className="section-title3 text-center m-0" 
                style={{backgroundImage:`url("images/title/title-3.webp")`}} data-bg-image>
                  <h2 className="title">Follow us on Facebook</h2>
                  <p className="desc">@studio4art</p>
                </div>
              </div>

              <div className="col learts-mb-50">
                <div id="instafeed" className="instafeed instafeed-carousel instafeed-carousel2"></div>
              </div>
            </div>
          </div>
        </div>
        {/* <!-- Gallery Section End --> */}

        <div className="footer1-section section section-padding">
          <div className="container">
            <div className="row text-center row-cols-1">

              <div className="footer1-logo col text-center">
                <img src="./images/web_logo3.png" alt="" />
              </div>

              <div className="footer1-menu col">
                <ul className="widget-menu justify-content-center">
                  <li><a href="contact-us.html">聯絡我們</a></li>
                  <li><a href="elements-faq.html">問與答</a></li>
                  <li><a href="element-return.html">退貨政策</a></li>
                  <li><a href="element-termsofservice.html">服務條款</a></li>
                </ul>
              </div>
              <div className="footer1-subscribe d-flex flex-column col">


                <div className="footer1-social col">
                  <ul className="widget-social justify-content-center">
                    <li className="hintT-top" data-hint="Facebook"> <a href="https://www.facebook.com/fany121105/photos/"><i className="fab fa-facebook-f"></i></a></li>
                    <li className="hintT-top" data-hint="Instagram"> <a href="https://www.instagram.com/studio4arttfa105/"><i className="fab fa-instagram"></i></a></li>
                    <li className="hintT-top" data-hint="Youtube"> <a href="https://youtu.be/YF5OK4_PEJM"><i className="fab fa-youtube"></i></a></li>
                  </ul>
                </div>
                <div className="footer1-copyright col">
                  <p className="copyright">&copy; 2022 studio4art. All Rights Reserved | <strong>(02) 27120589</strong> | <a href="mailto:cs@studio4art.com">studio4arttfa105@gmail.com</a></p>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/* <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a> */}
      </header>
    </div>
  );
}

export default App;
