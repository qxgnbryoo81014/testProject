// import logo from './logo.svg';
import {  Route, Routes, Link } from 'react-router-dom';
import React, { lazy, Suspense } from 'react';
import './App.css';
// import LoginFooter from './components/test';
const TestPage = lazy(() => import('./containers/account/TestPage'));
const App = props => {

//   main.js 依據 data-bg-image載入背景(不確定這邊怎麼做，直接寫入css-style)

//   $('[data-bg-image]').each(function () {
//     var $this = $(this),
//         $image = $this.data('bg-image');
//     $this.css('background-image', 'url(' + $image + ')');
// });
  return (
    <div className="App">
      <Suspense fallback={<div id="mask" className="mask"><div className="processing"><h1>處理中，請稍後...</h1></div></div>}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/abc" element={<TestPage />} />
          <Route path="/about" element={<About />} />
        </Routes>
      </Suspense>
    </div>
  );
}

function Home() {
  return (
    <>
      <main>
        <h2>Welcome to the homepage!</h2>
        <p>You can do this, I believe in you.</p>
      </main>
      <nav>
        <Link to="/about">About</Link>
      </nav>
    </>
  );
}

function About() {
  return (
    <>
      <main>
        <h2>Who are we?</h2>
        <p>
          That feels like an existential question, don't you
          think?
        </p>
      </main>
      <nav>
        <Link to="/">Home</Link>
      </nav>
    </>
  );
}
export default App;
