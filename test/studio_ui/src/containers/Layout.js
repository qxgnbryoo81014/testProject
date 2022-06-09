import React, { Fragment, useContext } from 'react';
import TopNav from '../components/Navigation/TopNav';
import SideNav from '../components/Navigation/SideNav';
import Footer from '../components/Footer/Footer';
import ActiveContext from '../context/ActiveContext';

const Layout = props => {
    const [active] = useContext(ActiveContext);

    return (
    <Fragment>
        <div id="mask" className={active ? 'mask' : 'mask-none'}>
            <div className='processing'>
                <h1>處理中 ...</h1>
            </div>
        </div>
        <TopNav showOptions={true}/>
        
        <div className="container-fluid">
            <div className="container-box">
                <div id="menu_mwt1">
                    <SideNav />
                </div>

                <div id="menu_mwt2">
                    {/* menu_a1 and menu_a2 are SideNav togglers. */}
                    <div id="menu_a1"></div>
                    <div id="menu_a2"></div>

                    <div className="by-component">
                        {props.children}
                    </div>
                    
                </div>
            </div>            
            <Footer />
        </div>
    </Fragment>
);}

export default Layout;