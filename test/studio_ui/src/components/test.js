import React from 'react';

const LoginFooter = props => (
    // ('[data-bg-image]').each(function () {
    //     var $this = $(this),
    //         $image = $this.data('bg-image');
    //     console.log("hi");
    //     $this.css('background-image', 'url(' + $image + ')');
    // });
    <footer className="login_footer" style={{color:'black'}}>
        <div className="home1-slide-item swiper-slide" 
        data-swiper-autoplay="5000" 
        data-bg-image="images/slider/home1/index_banner5.png"
        >
            {props.showStar}<br/>
            ttttt
        </div>
        <div className="login_footer_txt">
            <p>地址：115台北市南港區南港路三段50巷7號4樓</p>
            <p>諮詢服務專線：02-27858898　<span>E-Mail：<a href="mailto:cs@universalec.com">cs@universalec.com</a></span></p>
            <p>汎宇電商股份有限公司版權所有 ©copyright 2021</p>
        </div>
    </footer>
);

export default LoginFooter;