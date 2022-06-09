import React, { Fragment } from 'react';
// import { useForm, Controller } from 'react-hook-form';
import { Link } from 'react-router-dom';
// import React, { useState, useEffect, useCallback, lazy, Suspense } from 'react';

// const pageList = [
//     { name: '申請人填寫基本資料' },
//     { name: '新增作業' }
// ];

const TestPage = props => {

    return (
        <Fragment>
            <div><h1>hello wtf</h1></div>
            
            <nav>
                <Link to="/about">About</Link>
            </nav>
        </Fragment>
    );
}

export default TestPage;
